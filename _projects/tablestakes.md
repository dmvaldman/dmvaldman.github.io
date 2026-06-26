---
layout: draft
title: TableStakes
excerpt: Split the bill the fun way — with math
date: 2026-06-16
link: tablestakes.cc
tags: [Web]
---

Years ago I came across a [fascinating article](https://messymatters.com/expectorant/) about these staticians who devised a way to split a bill that's as fast as "credit card roulette" (one person chosen randomly pays for everyone) but fair! Amazingly, the process only asks for a single piece of information about the meal.

Like credit card roulette, one person pays the bill, but that person is selected probabilistically. If you keep using the app, on average you will pay what you owe, and there is no way to cheat. The mental frame is that though in reality, you never actually pay what you owe, you are always paying what you owe "in expectation". That is, the chance you pay the bill is equal to your share of it. But still, how can you figure out what everyone's chances are based on a single piece of information?

Here's how it works, and it's quite simple, though counterintuitive. Imagine the bill as a pie, and all the items are wedges with area equal to their percent of the total. Now, throw a dart at the pie. Whoever's item the dart lands on pays for the meal. That's it! It's straightforward to see that the probability the dart lands on one of your items is exactly your share of the bill. Notice though, we don't need to keep a record of who bought what, we just need to ask who bought the item the dart landed on. By choosing an item weighted by its cost, you're encapsulating all the info you need to choose the right person fairly.

A few questions off the bat:

- **What if more than one person ordered the item selected?**\\
Randomly pick the person from the people that ordered it. Whoever is picked pays.

- **What if the item picked was shared between people?**\\
Randomly pick the person from the people who shared it. Whoever is picked pays.

- **What if you never eat with the same people again?**\\
All that matters is how many times you play, not who you eat with. The fewer times you play, you can be lucky or unlucky, but if you play a lot, it will work out.

- **What about tipping?**\\
If you assume tip is just a fixed percentage of the cost of each item, then tips (and tax) don't change the probabilities (the wedges stay the same size). But if different payers tip differently, that's on them.

The originators of the idea created an app for it, but it sorely needed a refresh, so I made [TableStakes](https://tablestakes.cc).

## Analysis

Let's now analyze this game mathematically to see just how fair it is.

Say the $i^{\text{th}}$ bill has total $T_i$, and your actual share (which we don't know) is $s_i$. You'll pay it with probability $p_i = \frac{s_i}{T_i}$, otherwise you pay nothing. Let's define what you actually pay as a random variable $X_i$.

$$
X_i =
\begin{cases}
T_i & \text{with probability } p_i,\\
0   & \text{with probability } 1 - p_i,
\end{cases}
\qquad
X_i = T_i B_i, \quad B_i \sim \mathrm{Bernoulli}(p_i)
$$

Each meal is a Bernoulli trial with probability $p_i$ scaled by the bill total. Let's define your luck as what you owed minus what you actually paid: $L_i = s_i - X_i$. This is mean 0 and variance is the variance of $X_i$ which is $T_i^2 p_i (1 - p_i)$ (the variance of a Bernoulli trial scaled by $T_i$). We want to track how your luck $L_i$ evolves over many meals

$$
L = \sum_{i} L_i \\
$$

By the central limit theorem, your aggregate luck is approximated by a normal distribution $L \sim N(0, \sigma^2)$. Since each meal is independent, the variance of this distribution is the sum of variances of each meal

$$
\sigma^2 = \sum_{i} T_i^2 p_i (1 - p_i)
$$

So though your expected luck is 0, the variance of your luck accumulates with each meal. So your luck can really get pretty high (or low). But what's important to consider is not just how lucky you are at any time, but your luck as a percentage of what you owe $S = \sum_i s_i$. This is the percent error of what you pay vs what you owe. For roughly similar meals, $S$ grows like $n$, while the typical size of $L$ grows like its standard deviation, which grows like $\sqrt n$. So

$$
\frac{L}{S} \sim \frac{\sqrt n}{n} \to 0
$$

This is the precise sense in which TableStakes evens out: as you keep playing, the amount you are ahead or behind becomes vanishingly small compared to the total amount you owe.

Something else to notice about $\sigma^2$ is that the bill's totals $T_i$ enter in quadratically, so larger bills dominate the variance. So if you get stuck paying a bill five times larger than normal, you should expect it to take roughly twenty-five normal meals before that meal is washed out.