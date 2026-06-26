---
layout: draft
title: TableStakes
excerpt: Split the bill the fun way — with math
date: 2026-06-16
link: tablestakes.cc
tags: [Web]
---

Years ago I came across a [fascinating article](https://messymatters.com/expectorant/) about these staticians that devised a way to split a bill that's as fast as "credit card roulette" but fair! Amazingly, the process asks for just a single piece of information about the meal.

Like credit card roulette, one person pays the bill, but that person is selected probabilistically. If you keep using the app, on average you will pay what you owe, and there is no way to cheat. The mental frame is that though in reality, you never actually pay what you owe, you always pay what you owe "in expectation". That is, the chance you pay the bill is equal to your share of it. Order just an OJ, your chance is small, order the filet mignon your chance is big. But still, how can you figure out what everyone's chances are based on a single piece of information?

Here's how it works, and it's quite simple! Imagine the bill as a pie, and all the items are wedges with area equal to their percent of the total. Now, throw a dart at the pie. Whoever's item the dart lands on pays for the meal. That's it. It's straightforward to see that the probability the dart lands on one of your items is exactly your share of the bill. Notice though, we don't need to keep a record of who bought what, we just need to arrange the items (in whatever order), throw a dart at it, and then ask who bought the item the dart landed on. We only need one piece of info!

A few questions off the bat:

- **What if more than one person ordered the item selected?**\\
Randomly pick one of the people. Whoever is picked pays.

- **What if the item picked was shared between people?**\\
Randomly pick the payer among those who shared it.

- **What if you never eat with the same people again?**\\
All that matters is how many times you play, not who you eat with. The fewer times you play, you can be lucky or unlucky, but if you play a lot, it will work out.

- **What about tipping?**\\
If you assume tip is just a fixed inflated percentage of the cost of each item, then tips (and tax) don't change the probabilities (the wedges stay the same size). But if different payers tip differently, that's their sunk cost.

The originators of the idea created an app for it, but I felt it sorely needed a refresh, so I made [TableStakes](https://tablestakes.cc).

## Analysis

Let's now analyze this game mathematically to see just how fair it is.

Say the $i^{\text{th}}$ bill has total $T_i$, and your actual share is $s_i$. You'll pay it with probability $p_i = \frac{s_i}{T_i}$, otherwise you pay nothing. Let's define what you actually pay as a random variable $X_i$.

$$
X_i =
\begin{cases}
T_i & \text{with probability } p_i,\\
0   & \text{with probability } 1 - p_i,
\end{cases}
\qquad
X_i = T_i B_i, \quad B_i \sim \mathrm{Bernoulli}(p_i)
$$

Each meal is a Bernoulli trial with probability $p_i$ scaled by the bill total. Let's define your luck as what you owed (which we don't know) minus what you actually paid: $L_i = s_i - X_i$. This is mean 0 and variance is the variance of $X_i$ which is $T_i^2 p_i (1 - p_i)$ (the variance of a Bernoulli trial scaled by $T_i$). We want to track how your luck $L_i$ evolves over many meals

$$
L = \sum_{i} L_i \\
$$

By the central limit theorem, your aggregate luck is approximated by a normal distribution $L \sim N(0, \sigma^2)$. Since each meal is independent, the variance of this distribution is the sum of variances of each meal

$$
\sigma^2 = \sum_{i} T_i^2 p_i (1 - p_i)
$$

So though your expected luck is 0, the variance of your luck accumulates with each meal. Moreover, larger bills contribute quadratically. So your luck can really get pretty high (or low). But what's important to consider is not just how lucky you are at any time, but your luck as a percentage of what you owe $S = \sum_i s_i$, which is also growing with every meal. For roughly similar meals, $S$ grows like $n$, while the typical size of $L$ grows like its standard deviation, which grows like $\sqrt n$. So

$$
\frac{L}{S} \sim \frac{\sqrt n}{n} \to 0
$$

This is the precise sense in which TableStakes evens out: as you keep playing, the amount you are ahead or behind becomes vanishingly small compared to the total amount you owe. Though do keep in mind that larger bills you end up paying will make convergence slower.