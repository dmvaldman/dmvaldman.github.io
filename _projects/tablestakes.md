---
layout: post
title: TableStakes
excerpt: How statisticians split a bill
date: 2026-06-16
link: tablestakes.cc
tags: [Web]
---

How do *you* split a bill? Do you each get separate checks (slow but fair)? Does everyone split evenly (slow and unfair)? Does one person treat everyone (fast but unfair)? If only there were a way that was both fast and fair! Well, turns out there is, but it requires a certain amount of faith.

![](/assets/img/tablestakes/quadrants.png)

Years ago I came across a [fascinating article](https://messymatters.com/expectorant/) about statisticians who devised a way to split a bill that is both fast and fair, but based on chance. Amazingly, given the receipt, their procedure only asks for a single piece of information about the meal!

In their formulation, one person pays the bill, but that person is chosen probabilistically based on the meal. If you keep paying according to their rules, on average you will pay what you owe. And there's no way to cheat! A helpful mental frame is that though in reality you never actually pay what you owe, you are always paying what you owe "in expectation." That is, the chance you pay the bill is equal to your share of it. You operate calmly inside an uncollapsed platonic universe of probabilities, meanwhile violent collapse is happening all around you.

Here's how it works. It's quite simple, albeit counterintuitive. Imagine the bill as a pie, and each item is a wedge whose area is that item's fraction of the total. Now, throw a dart at the pie. Whoever's item the dart lands on pays for the meal. That's it! The probability the dart lands on one of your items is exactly your share of the bill (your share is the area of all your wedges over the area of the pie). Notice though, we don't need to keep record of who ordered what, we just need to ask who ordered the item the dart landed on. By choosing an item weighted by its cost, you're encapsulating all the information you need to choose the person fairly.

![](/assets/img/tablestakes/pie.png)

Of course, it's not that straightforward to select an item weighted by its cost in your head, so I made a web app [tablestakes.cc](https://tablestakes.cc) for that. For each meal, take a picture of the receipt and the app selects an item according to the above process. Whoever ordered that item pays!

A few edge cases to consider:

- **What if the item selected was shared between people?**\\
Choose the person based on how much of the shared item they had. E.g., if it was evenly shared, randomly pick the person. The way to see this is that we are now splitting the wedge the dart landed on into subwedges according to how much each sharer consumed and asking "which subwedge did the dart land on?"

- **What if more than one person ordered the selected item?**\\
Randomly pick the payer from the people that ordered the item. The way to see this is to imagine that all the items were really just one item shared evenly by each person who ordered it, and you are back in the case above where the item is evenly shared.

- **What if you never eat with the same people again?**\\
All that matters is how many times you play, not who you eat with. The fewer times you play, you can be lucky or unlucky, but if you play a lot, it will work out, and that's true for everyone you eat with, too.

## Analysis (optional)

That you are expected to pay what you owe is now clear, what's less clear is just how your actual payments drift from what you owe over time.

A few questions may come to mind:
- [How can I measure what I actually paid vs what I owe?](#how-can-i-get-a-sense-of-my-payouts-over-time-vs-what-i-owe)
- [How many times do I need to play before things "even out"?](#how-many-times-do-i-need-to-play-before-things-even-out)
- [Should I really use this for that fancy meal, or just that coffee with a friend?](#does-bill-size-matter)

Let's analyze this game rigorously to get at some of these questions.

Say the $i^{\text{th}}$ bill has total $T_i$, and what you actually owe (which we don't record) is $s_i$. You'll pay the bill with probability $p_i = s_i/T_i$, otherwise you pay nothing. Let's define what you actually pay, $X_i$, and your luck $L_i$ as what you owed minus what you paid:

$$
\begin{align}
X_i = &
\begin{cases}
T_i & \text{with probability } p_i,\\[0.4em]
0   & \text{with probability } 1 - p_i,
\end{cases} \\
L_i = & s_i - X_i
\end{align}
$$

Your luck $L_i$ is mean 0 and, since $s_i$ is fixed, its variance is the variance of $X_i$ which is $T_i^2 p_i (1 - p_i)$. We want to track how your luck $L_i$ aggregates over many meals $L = \sum_{i} L_i$. By the central limit theorem, your aggregate luck $L$ is approximated by a normal distribution. Since each meal is independent, the variance of this distribution is the sum of variances of each meal

$$
\begin{aligned}
L &\sim N(0, \sigma^2) \\[0.4em]
\sigma^2 &= \sum_i T_i^2 p_i (1 - p_i)
\end{aligned}
$$

The variance of your luck accumulates over time, but relative to what you owe, the error becomes negligible. Define $S = \sum_i s_i$ the sum of all you owe. A natural measure for comparing your payouts to what you should have spent is $L/S$, the percentage you are up/down versus what you owe.

$$
\frac{L}{S} \sim N\left(0, \left(\frac{\sigma}{S}\right)^2\right)
$$

### How can I get a sense of my payouts over time vs what I owe?

Though we don't record what you actually spent, we can estimate it. The app does gather how many people are dining together, $k_i$, so let's assume what you owe is an even split of the meal, $s_i = T_i/k_i$. Then $p_i = 1/k_i$ and

$$
\begin{align}
L = & \sum_i \left(\frac{T_i}{k_i} - X_i\right) \\[0.2em]
\sigma^2 = & \sum_i T_i^2 \frac{1}{k_i} \left(1 - \frac{1}{k_i}\right)
\end{align}
$$

(It turns out we can even relax the assumption that $s_i = T_i/k_i$ and need only to assume $\mathbb{E}(s_i)=T_i/k_i$ and the math works out to the same functional form. It's only if you consistently over- or under-order that this measure becomes biased.)

Now we can calculate $L/S$ and compare it to $\sigma/S$ to see what percent you are up/down versus what's expected. The app plots this over time. Here's my current view

![](/assets/img/tablestakes/luck_time.png)
*$L/S$ inside its $\pm 2\sigma/S$ envelope which narrows as $1/\sqrt n$. The 0% line is the even-split baseline.*

### How many times do I need to play before things "even out"?

$S$ grows linearly with the number of meals, while $L$ grows like its standard deviation, which scales like the square root of the number of meals. So for $n$ meals,

$$
\frac{L}{S} \sim \frac{\sqrt n}{n} \to 0
$$

As you keep playing, the amount you are ahead or behind becomes vanishingly small compared to the total amount you owe, and this ratio scales like $1/\sqrt n$. For example, after about 100 equal-sized meals you should usually be within 10% of what you owe.

### Does bill size matter?

Something to notice about $\sigma^2$ is that a bill's total enters your variance quadratically, so one that's $m$ times your usual carries about $m^2$ ordinary meals' worth of swing. It dominates your luck until you've logged roughly $m^2$ other meals, and fades only after that. The longer you play, though, the less any single bill can dominate. Equivalently, a bill only dominates all other meals when its total is more than $\sqrt n T_{\text{avg}}$.

If you keep playing, none of this matters, but to help track things in the early days, I'd reserve TableStakes for smaller bills until you accumulate a healthy total.

--------------

Give [TableStakes](https://tablestakes.cc) a try and do let me know how it goes!