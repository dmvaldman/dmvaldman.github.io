require 'kramdown'
require 'kramdown/parser/kramdown'

module Kramdown
  module Parser
    class MyParser < Kramdown::Parser::Kramdown
      def initialize(source, options)
        super
        @block_parsers.unshift(:chat_send_block, :chat_recv_block)
      end

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