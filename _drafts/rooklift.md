---
layout: draft
title: "RookLift"
excerpt: "Predict the variance of your intelligence from sleep & fitness metrics"
date: 2024-04-25
image: /assets/img/project-image.jpg
link: https://github.com/dmvaldman/rooklift
tags: [Garmin Watch]
---

Some days I'd wake up and know I was ready for the hard stuff---I'd be alert, clear-headed, present. Other days, I'd be retracing my steps 20 times to find my keys. Certainly this had to do with how I was sleeping and taking care of my body. I had been investing more into tracking these with a Garmin watch, and it was a big help, but it was clear it was also missing something. It was great at tracking the body but mediocre at tracking the mind.

There's another signal I use to track the mind, which is chess. I play almost daily, and winning or losing is a great proxy for how clear my thinking is. This was the signal absent from my Garmin which it needed to correlate all the others. It was time to build a Garmin watch app.

### Building a Model

I downloaded all my chess data from chess.com and Lichess, and all my Garmin data (about 1.5 years of cross-referenced signal at the time) and built a statistical model to see how well I could predict winning/losing at chess to my sleep and fitness metrics. I tried a lot of different models but worked best was good 'ol logistic regression. It could predict winning/losing with about 60% accuracy, which was much better than chance. But the more interesting question is: which signals were predictive? A sparse linear regression solver will show you which features of your model have little (or redundant) predictive power. I was pretty surprised by the answer.

- - Light sleep duration
- + REM sleep duration
- 0 Deep sleep duration
- + Stress duration
- + Stress average
- - Active calories
- 0 Sedentary duration

### Building the app