---
layout: post
title: "The Twists and Turns of Curved Labels"
date:	2017-03-13
excerpt: "Explorations in right-to-left text processing part two"
---

*This was originally written for Mapzen's blog [here](https://www.mapzen.com/blog/curved-labels/)*

>We turn the cube and it twists us. <br>
> <br>
*Ernő Rubik*

[Tangram JS v0.12](https://github.com/tangrams/tangram/releases/tag/v0.12.0) introduces curved labels, a feature that allows labels to curve along a road and smoothly animate when zoomed.

![](/assets/img/curved-labels/collage.png)

In this post we do a technical deep dive into the somewhat unusual way this feature was implemented.

## Technical Deep Dive

For labels to bend, they must first be broken up into pieces and reassembled along a curve. Each piece must be measured and placed along the line segments of the underlying geometry.

When the user zooms the map, the text stays the same size, but the road’s size will scale. Since the angle and position of the text needs to follow the road, they will have to animate. This creates the effect of the text stretching along the road as it shrinks or expands.

![](/assets/img/curved-labels/animation.gif)
![](/assets/img/curved-labels/animation_no_border.gif)

Recomputing the angles and positions of all the labels as the user scrolls is expensive and interrupts the fluid scrolling experience, so in Tangram JS, we take a shortcut. We figure out where the labels would be at four different zoom levels: 0, 0.33, 0.66, and 0.99 from the base zoom level.

![](/assets/img/curved-labels/stops.png)

We then interpolate between these values in the vertex shader to get an approximate value for any zoom. The naive way to do this would be to use a bunch of if statements to detect which zoom levels we are in between. This isn’t very performant though, as shader code doesn’t like conditionals. We do something a little more clever, perhaps too clever. With a combination of mix and step functions, you can create the same logic as a conditional. When you have to do this with cascading conditionals that have mix's in them for interpolation themselves… things get complicated.

### Language Support

Whenever you break text up and put it back together you must consider the language it comes from. For right-to-left (RTL) languages like Arabic and Hebrew, you may be putting the text back together [backwards](/writing/backwards-compatible)! Moreover, many languages have [text-shaping](https://en.wikipedia.org/wiki/Complex_text_layout) where a character is represented differently depending on the characters surrounding it. For example:
- In Greek, the σ (sigma) character is written differently if it occurs at the end of the word, as in σοφός (sofos)
- In Devanagari, the city of Taxila, Pakistan is spelled टैक्सिला, but the individual characters are क् + स + क्स.
- The Arabic character م can look like “ـم” or “ـمـ” or “مـ” depending on how it connects to surrounding characters.
- In Hindi, अशांत means “not quiet”, but अश + अंत means passage + the end.

These are a few of many examples of how complicated scripts can be, and how thinking of characters as atomic units stripped of their context can lead to wildly inaccurate results. For the interested reader, [this](https://r12a.github.io/scripts/tutorial/part3) is a great overview.

For languages with text-shaping we are forced to disable the label curving feature (for now). These languages are Arabic, Bengali, Burmese, Devanagari, Khmer, Gujarati, Gurmukhi, Kannada, Lao, Mongolian, Oriya, Tamil, Telugu and Tibetan. We do support RTL languages that don’t have text-shaping, such as Hebrew. In the research leading up to this feature, we’ve relied heavily on the work of Richard Ishida of the W3C such as [this handy chart](http://r12a.github.io/scripts/featurelist/).

### JavaScript vs Native Implementations

>In theory there’s no difference between practice and theory. In practice there is. <br>
> <br>
*Yogi Berra*

So far we’ve been detailing the JavaScript implementation for curved labels. Tangram ES, our native implementation for iOS, Android and other platforms, takes a different route for the same feature. This stems from important platform differences between web and native.

For the web, we measure widths of text using the `canvas.measureText` API and draw compound strings to an off-screen canvas element which gets converted to a texture. It’s by leveraging the canvas element’s built-in text rendering that enables TangramJS to render and measure text in any language and typographic style that canvas supports (which is a lot). We can load fonts from any font file at runtime and use the canvas built-in stroking and filling API to style text.

On the native side, Tangram ES comes bundled with [Harfbuzz](https://www.freedesktop.org/wiki/Software/HarfBuzz/), a sophisticated text layout engine written in C++. The API of Harfbuzz is much more versatile than what the web’s canvas can do. On the JS side, we could transpile Harfbuzz with emscripten, however that would lead to a much larger bundle size and longer intial load times.

In Tangram ES, each character of a string (whether straight or curved) is its own glyph (set of pixels referenced in a global texture). The ordering and placement of these glyphs is solved using Harfbuzz. As the user zooms, these values are recomputed on each tick. We can do that on Tangram ES because Harfbuzz is very fast and gives more granular information about the text string. In Tangram JS, however, measuring sizes is slower, and so we do it as infrequently as possible. Straight labels are drawn as a single texture, instead of being broken up by character. When no straight label can be placed, then we try to curve a label and break it up into pieces. We also do all the computation on initial tile load, so that if a user zooms, everything has been precomputed (as described above).