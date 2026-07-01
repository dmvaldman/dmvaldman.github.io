---
layout: draft
title: TableStakes
excerpt: How statisticians split a bill
date: 2026-06-16
link: tablestakes.cc
tags: [Web]
---

How do you split a bill? Do you each get separate checks (slow but fair)? Does everyone throw in their card and split evenly (slow and not fair)? Does one person pay and everyone else pays them (slow and maybe fair)? Does one person treat everyone (fast but not fair)? If only there was a way that was both fast and fair! Well, turns out there is, but it requires a certain amount of faith.

Years ago I came across a [fascinating article](https://messymatters.com/expectorant/) about these statisticians who devised a way to split a bill that's as fast as "credit card roulette" (one person chosen randomly pays for everyone) while also being fair. Amazingly, their algorithm only asks for a single piece of information about the meal!

In their formulation one person pays the bill, but that person is chosen probabilistically based on the meal. If you keep paying this way, on average you will pay what you owe. And there's no way to cheat! A helpful mental frame is that though in reality you never actually pay what you owe, you are always paying what you owe "in expectation". That is, the chance you pay the bill is equal to your share of it. You must exist calmly inside this uncollapsed platonic universe of probabilities, meanwhile violent collapse is happening all around you.

Here's how it works, and it's quite simple, albeit counterintuitive. Imagine the bill as a pie, and all the items are wedges making up the pie with area equal to the item's percent of the total. Now, throw a dart at the pie. Whoever's item the dart lands on pays for the meal. That's it! It's straightforward to see that the probability the dart lands on one of your items is exactly your share of the bill. Notice though, we don't need to keep record of who bought what, we just need to ask who bought the item the dart landed on. By choosing an item weighted by its cost, you're encapsulating all the information you need to choose the person fairly.

Of course, it's not that straightforward to select an item weighted by its costs in your head, so I made a web app [tablestakes.cc](tablestakes.cc) for that. For each meal, take a picture of the receipt and the app selects an item according to the above process, whoever bought that item pays!

A few edge cases to consider:

- **What if the item picked was shared between people?**\\
Choose the person based on how much of the shared item they had. E.g., it was evenly shared, randomly pick the person. The way to see this is that the dart landed on the wedge of a single item, and we are now splitting that wedge into subwedges according to how much each sharer consumed and asking which subwedge the dart landed on.

- **What if more than one person ordered the selected item?**\\
Randomly pick the payee from the people that ordered the item. The way to see this is that you can imagine that all the items were really just one item shared evenly by each person who ordered it, and you are back in the case above.

- **What if you never eat with the same people again?**\\
All that matters is how many times you play, not who you eat with. The fewer times you play, you can be lucky or unlucky, but if you play a lot, it will work out.

- **What about tipping?**\\
If you assume tip is just a fixed percentage of the cost of each item, then tips (and tax) don't change the probabilities (the wedges stay the same size). But if different payers tip differently, that's on them.

## Analysis (Optional)

That you are expected to pay what you owe is now clear, what's less clear is just how far from paying what you owe is at any given time and how it evolves as you keep paying (or not).

A few questions may come to mind:
- How can I measure what I actually paid vs what I should have paid?
- How many times do I need to play before things "even out"?
- Should I really use this for that michelin star meal I'm having tonight, or just that coffee with a friend?

Let's analyze this game rigorously to get at some of these questions. We're going to go deep but none of this is really needed to enjoy the experience.

Say the $i^{\text{th}}$ bill has total $T_i$, and your actual share (which we don't record) is $s_i$. You'll pay the bill with probability $p_i = \frac{s_i}{T_i}$, otherwise you pay nothing. Define what you actually pay as the random variable $X_i$.

$$
X_i =
\begin{cases}
T_i & \text{with probability } p_i,\\
0   & \text{with probability } 1 - p_i,
\end{cases}
\qquad
X_i = T_i B_i, \quad B_i \sim \mathrm{Bernoulli}(p_i)
$$

Each meal is a Bernoulli trial (coin flip) with probability $p_i$ scaled by the bill total. Let's define your luck $L_i$ as what you owed minus what you actually paid: $L_i = s_i - X_i$. This is mean 0 and, since $s_i$ is fixed, its variance is $T_i^2 p_i (1 - p_i)$ (the variance of a Bernoulli trial scaled by $T_i$). We want to track how your luck $L_i$ aggregates over many meals $L = \sum_{i} L_i$.

By the central limit theorem, your aggregate luck $L$ is approximated by a normal distribution. Since each meal is independent, the variance of this distribution is the sum of variances of each meal

$$
\begin{aligned}
L &\sim N(0, \sigma^2) \\
\sigma^2 &= \sum_i T_i^2 p_i (1 - p_i)
\end{aligned}
$$

So though your expected luck is 0, the variance of your luck accumulates with each meal. What's important to consider is not just how lucky you are at any time, but your luck as a percentage of what you owe $S = \sum_i s_i$, ie the percent error of what you pay vs what you owe.

$S$ grows linearly with the number of meals, while $L$ grows like its standard deviation, which scales like the square root of the number of meals. So for $n$ meals,

$$
\frac{L}{S} \sim \frac{\sqrt n}{n} \to 0
$$

In this sense the payments work out: as you keep playing, the amount you are ahead or behind becomes vanishingly small compared to the total amount you owe.

### How can I get a sense of my payouts over time vs what I should have spent?

Though we don't record what you actually spent, we can estimate it. The app does gather how many people are dining together, $k_i$, so all things being equal we can assume what you owe is an even split of the meal, $s_i = \frac{T_i}{k_i}$. Then $p_i = \frac{1}{k_i}$ and

$$
\begin{align}
L = & \sum_i \frac{T_i}{k_i} - X_i \\
\sigma^2 = & \sum_i T_i^2 \frac{1}{k_i} \left(1 - \frac{1}{k_i}\right)
\end{align}
$$

which we can calculate.

A measure of how lucky/unlucky you are is how many standard deviations out your luck is, $\frac{L}{\sigma} \sim N(0, 1)$. A positive score means you're on the lucky side of things, a negative score means you're on the unlucky side of things. You should expect to be within one standard deviation $\lvert \frac{L}{\sigma} \rvert \leq 1$.

It turns out we can even relax the assumption that what you owe is an even split of the meal. We only need to assume that on average you actually owe an even split of the meal and the math works out to the same functional form. It's only if you consistently over- or under-order does this measure become biased.

### How many times do I need to play before things "even out"?

Say you're particularly lucky or unlucky and $\lvert \frac{L}{\sigma} \rvert > \alpha$ where $\alpha > 1$. How much more do we need to play this game before we return to normalcy with $\lvert \frac{L}{\sigma} \rvert \leq 1$ again?

Since variance accumulates one meal at a time, $\sigma$ grows like the square root of the number of meals, so after $m$ more meals

$$
\sigma_{m + n} = \sigma_n \sqrt\frac{n + m}{n}
$$

So to reduce your luck by a factor of $alpha$ you'll need $m = n (\alpha^2 - 1)$ more meals.


### Should I use this for that fancy dinner meal or coffee with friends?

Something to notice about $\sigma^2$ is that the bill's totals $T_i$ enter in quadratically, so larger bills dominate the variance. If you get stuck paying a bill five times larger than normal, you should expect it to take roughly twenty-five normal meals before that meal is washed out. In general, a bill meaningfully skews the distribution if it's larger than $\sqrt n \bar{T}$ where $\bar{T}$ is the average bill size.

Something to notice about $\sigma^2$ is that a bill enters your variance quadratically, so one that's $k$ times your usual carries about $k^2$ ordinary meals' worth of swing. It dominates your luck until you've logged roughly $k^2$ other meals, and fades only after that. So a 5× michelin bill ($k^2 = 25$) skews your stats for the next ~25 dinners; that $6 coffee $k^2 \approx 0.02$ is invisible. (Equivalently, a bill matters whenever $T_{\text{big}} \gtrsim \sqrt n,\bar T$ — which is just $k^2 \gtrsim n$.)

## Real Usage

I've been using [TableStakes](https://tablestakes.cc) anytime a friend is willing to entertain the idea. Here's been my experience so far

<div class="image-grid">
<img src="/assets/img/tablestakes/luck_time.png" alt="luck over time">
<img src="/assets/img/tablestakes/luck_current.png" alt="current luck">
</div>
*$\frac{L}{S}$ over time decaying like $\frac{1}{\sqrt n}$*

The app shows your relative luck $\frac{L}{S}$ over time using an assumption of equal splitting $s_i = \frac{T_i}{k_i}$ (where $k_i$ are the number of people splitting meal $i$) as a baseline. We can see that the error is decreasing like $\frac{1}{\sqrt n}$ which is pretty cool to see!
