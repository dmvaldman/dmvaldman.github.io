---
layout: post
title: "Make Your Code Backwards (and Compatible)"
date:	2016-11-09
excerpt: "Explorations in right-to-left text processing"
image:
---

*This was originally written for Mapzen's blog [here](https://www.mapzen.com/blog/backwards-and-compatible/)*

In Lewis Carroll’s Through the Looking Glass, Alice finds a mysterious book that’s “all in some language [she doesn’t] know”. It begins with

> YKCOWREBBAJ<br>
> <br>
> sevot yhtils eht dna,gillirb sawT'<br>
> ebaw eht ni elbmig dna eryg diD<br>
> ,sevogorob eht erew ysmim llA<br>
> .ebargtuo shtar emom eht dnA

[Tangram.min.js](https://github.com/tangrams/tangram/blob/master/dist/tangram.min.js) looked somewhat similar between versions 0.10.0 and 0.10.5. A large part of our code was backwards. Like the poem of Jabberwocky, you need a mirror to read it.

![escape](/assets/img/backwards-compatible/backwards_source.png)
*sj.nim.margnaT*

And yet, everything still worked as expected! The code only appears to go left, but its logic is all right. You can verify it for yourself by executing this simpler JavaScript example:

```js
'‮';(function (){ console.log('through the looking glass');} )();
```

Here’s the story of how this happened, and how you, too, can make your code backwards (and compatible).

## Maps and Labels

First, some context. Our maps render text in hundreds of languages. One place we do this is to label roads, and we’ve been recently experimenting with curving text along roads. This comes down to breaking up a label’s text into pieces, and reassembling them along a curve.

![LTR_labels.gif](/assets/img/backwards-compatible/LTR_labels.gif)

## Taking Apart and Putting Back Together

> All the king’s horses and all the king’s men
>
> Couldn’t put Humpty together again.

It’s important that when you put letters back together they’re not out of order. However, ordering text is not as straightforward as it seems.

![escape](/assets/img/backwards-compatible/escape.gif)
*Escaping unicode takes on new meaning*

To dissassemble and reassemble parts of text, we need to know whether the characters are right-to-left, as they are in Hebrew, Arabic and several other languages, or left-to-right. In Tangram.js we use the following code to detect this:

```js
function isRTL(string){
    var weakChars = '\u0000-\u0040\u005B-\u0060\u007B-\u00BF\u00D7\u00F7\u02B9-\u02FF\u2000-\u2BFF\u2010-\u2029\u202C\u202F-\u2BFF',
        rtlChars = '\u0591-\u07FF\u200F\u202B\u202E\uFB1D-\uFDFD\uFE70-\uFEFC',
        rtlDirCheck = new RegExp('^['+weakChars+']*['+rtlChars+']');

    return rtlDirCheck.test(string);
}
```

For instance, `isRTL("hello")` will be `false` and `isRTL("العالم")` will be `true`. Those `\u****` expressions are unicode ranges that tell what alphabet a letter comes from. For example, `\uFE70-\uFEFC` is the range of Arabic characters between [`ﹰ`](https://en.wiktionary.org/wiki/%D9%8B) and [`ﻼ`](https://en.wiktionary.org/wiki/%D9%84%D8%A7).

This lets us render right-to-left languages with ease and curve them along roads just like any left-to-right language.

![escape](/assets/img/backwards-compatible/RTL_labels.gif)

## Escaping Unicode

When unicode is interpreted, it is immediately escaped, turning it into the text it represents. This way you can type \u00A9 and get the copyright symbol ©. When our source code was bundled by browserify, our unicode was escaped and the code above became

```js
function isRTL(string) {
    var weakChars = '\u0000-@[-`{-¿×÷ʹ-˿ -⯿‐-\u2029‬ -⯿',
        rtlChars = '֑-߿‏‫‮יִ-﷽ﹰ-ﻼ',
        rtlDirCheck = new RegExp('^[' + weakChars + ']*[' + rtlChars + ']');
    return rtlDirCheck.test(string);
}
```

Surprisingly, this code still works! `isRTL("hello")` is still true. Some may even argue this version is just as cryptic than the original. Nonetheless, our codebase has some new and colorful characters. You can see the Hebrew Hiriq (יִ), the symbol [߿](http://www.fileformat.info/info/unicode/char/07ff/index.htm) (which is the “not a valid character” character), and the Arabic [Basmala](https://en.wikipedia.org/wiki/Basmala) (﷽). The Basmala is an Arabic phrase, drawn as a single unicode character, which translates to “In the name of God, the Most Gracious, the Most Merciful”. A religious mantra snuck into our source code!

Now we can explain why our minified source code was backwards. One of the unicode characters in our regular expression above, `\u202E`, is the [right-to-left override](http://www.fileformat.info/info/unicode/char/202e/index.htm) character, which forces all subsequent text to render right-to-left until there is either a newline character, or a left-to-right override character to stop it. The RTL override character then acted on a large chunk of our own source code! Before minification, it only acted on the line on which it appeared. After minification this effect became exaggerated because the thousands of lines of our codebase collapsed to about 20, and a large part of one of those lines was rendered backwards.

## You, too, can write code backwards

We thought this was so cool that we made an [npm script](https://github.com/dmvaldman/elba) for it. You can install it with

```
npm install -g elba
```

Making the code in myFile.js backwards is as simple as

```
elba myFile.js > eliFym.js
```

For example, [here’s](https://gist.githubusercontent.com/dmvaldman/8238a65a460ffea046888c1872db66f5/raw/93524334384bda6c0a668a717d785ffad4034fb2/erocsrednu.js) elba applied to the popular [underscore.js](https://github.com/jashkenas/underscore) library. And yes, it works! 🙃