---
layout: draft
title: "RookLift"
excerpt: "Measuring mental clarity from my Garmin watch and Chess ELO"
date: 2024-04-25
tags: [Garmin Watch]
---

Some days I'd wake up and know I was ready for the hard stuff---I'd be alert, clear-headed, present. Other days, I'd be retracing my steps 20 times to find my keys. Certainly this had to do with how I was sleeping and taking care of my body. I had been investing more into tracking these with a Garmin watch, and it was a big help, but it was clear it was also missing something. Though great at tracking the body, it was mediocre at tracking the mind.

There's another signal I was using to track the mind, which is chess. I play almost daily, and winning or losing is a good proxy for how clear my thinking is. This was the signal absent from my Garmin which it needed to correlate all the others. It was time to verify if I was right.

## Building a Model

I downloaded my chess data from Chess.com and Lichess, and all my Garmin data (about 1.5 years of cross-referenced signal at the time) and built a statistical model to see how well I could predict winning/losing at chess from sleep and fitness metrics. I tried a lot of different models but what worked best was good 'ol logistic regression. It could predict winning/losing with about 60% accuracy, which was much better than chance.

![](/assets/img/rooklift/accuracy.png)
*Cross validation analysis*

But the more interesting question is: which signals were predictive? I was tracking about 30 separate features. Using a sparse linear regression solver is a fast trick to show which of them have little (or redundant) predictive power. I was pretty surprised by the answer.

| Feature | Correlation |
| --- | --- |
| Light sleep duration | Negative |
| REM sleep duration | Positive |
| Deep sleep duration | None |
| Stress duration | Positive |
| Stress average | Positive |
| Active calories | Negative |
| Sedentary duration | None |

To be smart, I need to be stressed out, get plenty of REM and avoid exercise. I'm dumber when most of my sleep is light and after working out.

Who knew? Upon closer reflection, though, this does actually make some sense. Your body's energy goes into body recovery post exercise, away from your brain, and stress increases adrenaline which sharpens focus. Near-term clarity and long-term clarity are often at odds.

## Building the app

With a predictive model in hand, I decided to make an app for my watch that would tell me each day how smart or dumb I was. Every week the model would update based on new data, and each morning the previous day's data would predict my mental clarity and break down where I landed on each of the important features.

<div class="image-grid">
<img src="/assets/img/rooklift/watch2.jpg" alt="glance view">
<img src="/assets/img/rooklift/watch1.jpg" alt="fullscreen view">
</div>
*Glance view and Fullscreen view*

Writing a Garmin app is no fun, let me tell you. They have their own proprietary language (Monkey C) with zero 3rd party library support (I had to write my own JSON parser at one point), scant documentation, and jump through a lot of hoops because they're very battery life conscious (which makes sense). You wouldn't be able to tell from their documentation, though, which raves about their developer experience

<div class="image-grid">
<img src="/assets/img/rooklift/doc1.png" alt="">
<img src="/assets/img/rooklift/doc2.png" alt="">
<img src="/assets/img/rooklift/doc3.png" alt="">
</div>

## Publishing the App?

I'd like to put this app into the Garmin marketplace, but because Garmin doesn't provide sleep data on device (see [this](https://forums.garmin.com/developer/connect-iq/i/bug-reports/feature-request-add-sleep-data-to-the-sdk) 3-year-old feature request) and are also very restrictive on OAuth permissioning for hobby projects, it can only be a personal tool. Hope that changes at some point! If you'd like to see the code, here's what [builds the model and runs daily cron jobs](https://github.com/dmvaldman/rooklift) and here's the [frontend for the watch UI](https://github.com/dmvaldman/rooklift-frontend)

![](/assets/img/rooklift/logo.png)
