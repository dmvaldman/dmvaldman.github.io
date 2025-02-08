require 'kramdown'
require 'kramdown/parser/kramdown'

module Kramdown
  module Parser
    class MyParser < Kramdown::Parser::Kramdown
      def initialize(source, options)
        super
        @block_parsers.unshift(:highlight_block, :chat_send_block, :chat_recv_block)
        @span_parsers.unshift(:highlight_span)
      end

      # Highlight block parser (existing code)
      HIGHLIGHT_START = /^<highlight>\s*?\n/
      HIGHLIGHT_END = /^<\/highlight>\s*?\n/
      HIGHLIGHT_SPAN = /<highlight>(?<content>.*?)<\/highlight>/m

      def parse_highlight_span
        # Use scan—which advances @src automatically—rather than manually moving @src.pos.
        if @src.scan(HIGHLIGHT_SPAN)
          content = @src[:content]
          # Create a span element with the highlight class.
          el = new_span_el(:html_element, 'span', {'class' => 'highlight'})
          parse_spans(el, content)
          @tree.children << el
        end
      end
      define_parser(:highlight_span, HIGHLIGHT_SPAN)

      def parse_highlight_block
        @src.pos += @src.matched_size
        content = @src.scan_until(HIGHLIGHT_END)
        if content
          content = content.sub(HIGHLIGHT_END, '')
          block = new_block_el(:html_element, 'div', {'class' => 'highlight'})
          parse_blocks(block, content)
          @tree.children << block
        end
      end
      define_parser(:highlight_block, HIGHLIGHT_START)

      # Chat send block parser
      CHAT_SEND_START = /^<chat_send>\s*?\n/
      CHAT_SEND_END = /^<\/chat_send>\s*?\n/

      def parse_chat_send_block
        @src.pos += @src.matched_size
        content = @src.scan_until(CHAT_SEND_END)
        if content
          content = content.sub(CHAT_SEND_END, '')
          block = new_block_el(:html_element, 'div', {'class' => 'chat-bubble chat-send'})
          parse_blocks(block, content)
          @tree.children << block
        end
      end
      define_parser(:chat_send_block, CHAT_SEND_START)

      # Chat receive block parser
      CHAT_RECV_START = /^<chat_recv>\s*?\n/
      CHAT_RECV_END = /^<\/chat_recv>\s*?\n/

      def parse_chat_recv_block
        @src.pos += @src.matched_size
        content = @src.scan_until(CHAT_RECV_END)
        if content
          content = content.sub(CHAT_RECV_END, '')
          block = new_block_el(:html_element, 'div', {'class' => 'chat-bubble chat-recv'})
          parse_blocks(block, content)
          @tree.children << block
        end
      end
      define_parser(:chat_recv_block, CHAT_RECV_START)
    end
  end
end