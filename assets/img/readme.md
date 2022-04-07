Convert to 16/9 size
```magick convert in.jpg -gravity center -crop 16:9 out.jpg```

Reduce img size
```convert in.jpg -sampling-factor 4:2:0 -strip -quality 85 -interlace out.jpg```