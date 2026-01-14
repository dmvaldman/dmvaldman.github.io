---
layout: post
title: "RookLift"
excerpt: "Measuring mental clarity by correlating Chess ELO to my Garmin watch"
date: 2024-04-25
tags: [Garmin]
---

![](/assets/img/rooklift/logo.png)

Some mornings I'd wake ready for the world---I'd be alert, clear-headed, present. Other days, I'd retrace my steps 20 times to find my keys, dreading the long day ahead. My sleep was erratic and I didn't know why. I had invested in a Garmin watch to clarify trends, and it was helping, but it was also missing something. Though great at tracking the body, it was mediocre at tracking the mind.

There's another signal I was using to track the mind, which is chess. I play almost daily, and I found winning or losing to be a good proxy for mental clarity. Chess was the signal absent from my Garmin that I hoped could bridge body to mind. Time to verify if I was right.

## Building a Model

I downloaded my chess data (`date`, `ΔELO`) from Lichess, and my Garmin data (about 1.5 years of cross-referenced signal) and put on my data science hat. I was tracking ~20 signals related to exercise and sleep and from them built various statistical models to predict my daily [ELO](https://en.wikipedia.org/wiki/Elo_rating_system) fluctuations. What worked best was also the simplest: tried and true logistic regression. I could predict winning/losing with about 60% accuracy (and confirmed that number through cross-validation). 60% seemed pretty good: absent any signal, the chance of winning should be about 50% because chess apps pair you with like-ELO players.

That I could do better than chance wasn't too surprising. A lot of cognition depends on how well you sleep and exercise. But what exactly does it mean to sleep and exercise well? Which of the signals were actually important? Using a sparse logistic regression solver is a straightforward method to show which features have little (or redundant) predictive power, and I was pretty surprised by the results. Here's a sample of independent signals from most positively correlated to most negatively correlated

| Feature | Correlation |
| --- | --- |
| <span style="color: #4CAF50">REM sleep duration</span> | <span style="color: #4CAF50">Positive</span> |
| <span style="color: #4CAF50">Stress<sup>*</sup> duration</span> | <span style="color: #4CAF50">Positive</span> |
| <span style="color: #4CAF50">Stress<sup>*</sup> average</span> | <span style="color: #4CAF50">Positive</span> |
| <span style="color: #878580">Deep sleep duration</span> | <span style="color: #878580">None</span>
| <span style="color: #878580">Sedentary duration</span> | <span style="color: #878580">None</span> |
| <span style="color: #F44336">Active calories</span> | <span style="color: #F44336">Negative</span> |
| <span style="color: #F44336">Light sleep duration</span> | <span style="color: #F44336">Negative</span> |

*<sup>*</sup>Stress is a proprietary algorithm of Garmin's creation but is best approximated by 1 / HRV*

REM sleep was out on top, which isn't much of a surprise. But apparently ***it helps to be stressed out and avoid recent exercise***.

***Exercise Made Me Dumber*** -- I'd assumed fitness and sharpness went together. And long-term they probably do, but short-term, you're pitting body against mind. The literature confirms this: exercise-induced fatigue impairs complex cognitive tasks.[^1]

***Deep Sleep had no Effect*** -- Supposedly the most restorative phase, but unhelpful for chess. Chess demands working memory and planning, and research shows it's REM and not deep sleep that targets these capacities.[^2][^3]

***Stress Made Me Smarter*** -- As inverse HRV, Garmin's stress signal really measures your sympathetic nervous system, which is also heightened during alertness and engagement, not just anxiety. According to the [Yerkes-Dodson law](https://en.wikipedia.org/wiki/Yerkes%E2%80%93Dodson_law), moderate arousal improves performance on complex tasks. For your mind to be clear, you actually don't want to be very relaxed.

The takeaway is that near-term mental clarity and long-term health aren't that aligned. This is I think why Garmin's sleep metrics can often be miscalibrated with performance. To Garmin, for example, stress is always bad. Moreover, this was a model built custom for my data---I wasn't fitting into some aggregated statistics of Garmin's design.

## Building a Garmin App

With a better model in hand, I decided to make a better model on my hand. I was going to make a Garmin watch app that would tell smart from dumb. Each morning it would turn the previous day's metrics into the probability my ELO would go up that day. The model would also update weekly with the new data and I'd be able to verify if the same features were consistently predictive (which by and large they were).

<div class="image-grid">
<img src="/assets/img/rooklift/watch2.jpg" alt="glance view">
<img src="/assets/img/rooklift/watch1.jpg" alt="fullscreen view">
</div>
*Glance view and Fullscreen view*

If curious about the code, here's what [builds the model and runs daily cron jobs](https://github.com/dmvaldman/rooklift) and here's the [frontend for the watch UI](https://github.com/dmvaldman/rooklift-frontend).

## Reflections on Use

I've been using the app for several months now. It's definitely predictive not only of my chess aptitude but other cognitively demanding tasks, at times contradicting Garmin's "morning review". Often, it would also contradict how I was internally feeling. I'd wake up feeling rested, see my stats are low, and play a game of chess out of algorithmic rebellion, only to feel my mind up against a barrier and handedly lose. I've now been taking its predictions more seriously and scheduling less demandingly cognitive tasks when my metrics are low, adopting a "we'll get em next time" strategy.

I've also made some behavior changes. I've invested much more into getting enough REM sleep. What's helped the most has been cutting down alcohol. I'll avoid the "have a glass of wine to relax" thing. Even a single serving of alcohol disproportionately impares REM sleep.[^4] Begrudgingly, I've adopted another west-coast trope. Getting a weighted blanket has also helped me be get more REM and deep sleep and fewer 5am wakeups for no reason.

I'd like to put this app into the Garmin marketplace, but unfortunately Garmin [doesn't provide](https://forums.garmin.com/developer/connect-iq/i/bug-reports/feature-request-add-sleep-data-to-the-sdk) sleep data on device and is also very [restrictive](https://stackoverflow.com/questions/53454382/can-i-get-access-to-the-garmin-health-api-as-a-hobbyist) on hobby projects that need Health API access. For now it can only be a personal tool. Hope that changes at some point! Do reach out if you want one for yourself and I can help you set up a local version.

-------

[^1]: [The influence of exercise-induced fatigue on cognitive function](https://pubmed.ncbi.nlm.nih.gov/22494399/)
[^2]: [Cognitive flexibility across the sleep-wake cycle: REM-sleep enhancement of anagram problem solving](https://pubmed.ncbi.nlm.nih.gov/12421655/)
[^3]: [How Memory Replay in Sleep Boosts Creative Problem-Solving](https://pmc.ncbi.nlm.nih.gov/articles/PMC7543772/)
[^4]: [Alcohol Consumption Impairs REM Sleep](https://www.rheumatologyadvisor.com/news/alcohol-impairs-rem-sleep/)