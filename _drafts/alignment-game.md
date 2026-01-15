---
layout: draft
title: "The Alignment Game"
excerpt: A Game to Align People and Priorities
date: 2023-09-08
link: https://docs.google.com/spreadsheets/d/1BYh9ZtEv4k7xoSXmtf1qCP8bYHBCZLEuTVHsTDPQM1M/edit?gid=2033972304#gid=2033972304
tags: ["Google Sheet"]
---

*TLDR; I made a game to align people and priorities in a [Google Sheet](https://docs.google.com/spreadsheets/d/1BYh9ZtEv4k7xoSXmtf1qCP8bYHBCZLEuTVHsTDPQM1M/edit?gid=2033972304#gid=2033972304)*

At work as an "executive" I found myself often focused on issues of "alignment," especially among the other execs. It just turns out as organizations grow, they operate on a fractured set of implicit assumptions. I found there is often little disagreement on *what* the problems are, but plenty of disagreement on *which* were more important. People then carry these differences into decision making without revealing their working assumptions, cascading tradeoffs are made and efforts diverge. There was an incredible sense of clarity when everyone could agree on what's most important in unison, and I wanted to get there.

I started by doing the exercise of stack ranking priorities. Sometimes this would just be finger to the wind thinking about issues, sometimes this would mean months of work to assess impact rigorously. I would challenge others in the company to make their own stack rankings. We'd then discuss the differences and try to converge on a shared ordering. This was an incredibly fruitful exercise that led to great conversations. With more than two people though, as with an exec team, there was a need for more process.

It turns out there's a whole branch of mathematics called [voting theory](https://en.wikipedia.org/wiki/Social_choice_theory) all about how to get a plurality of people to agree on a single thing. The concepts of [run-off elections](https://en.wikipedia.org/wiki/Instant-runoff_voting), ["I cut, you choose"](https://en.wikipedia.org/wiki/Divide_and_choose) division algorithms, and [how medical schools select students](https://en.wikipedia.org/wiki/National_Resident_Matching_Program#Matching_algorithm) through ranked preferences are all facets of voting theory.

In my situation, we had a half dozen stack ranked lists of priorities and we wanted to align people on a single ordering. Turns out, there is [no algorithm](https://en.wikipedia.org/wiki/Condorcet_paradox) that always works! You can always find yourself in a situation where more than half of people want A over B, some other half want B over C, and some other half want C over A, so regardless of ordering, a majority are upset with any outcome. But there are algorithms that make better tradeoffs than others.

## Kemeny Ranking

The [Kemeny-Young method](https://en.wikipedia.org/wiki/Kemeny_method) is a ranking algorithm that finds the ordering which minimizes total disagreement across all voters. A disagreement is any time one voter chooses A over B and another chooses B over A. One of the voters would need to swap their preferences in order to align, and the Kemeny Young method finds the ordering requiring the fewest pairwise swaps across all voters.

The downsides of the Kemeny Young method come down to it being the "compromise solution". Half of people may think A is most important and B least, and another half would invert that, and the Kemeny Young method would put it in the middle and upset everyone. Something to be cognizant of. The important bit is not to use the ordering it gives you as marching orders, but to use it as a tool for conversation.

The benefits of Kemeny Young lies in its interpretability. Because it works by counting pairwise disagreements, you get a natural measure of which items are contentious and which aren't and which voters are misaligned and which aren't. It can be said of any two people: "You have X disagreements", "You need to change your mind on X things to align with one another".

## Playing the Game

We had great success playing the game. Each person would make their ranking in private, we'd gather them all, churn through an algorithm and immediately all implicit tradeoffs are surfaced. We would then meet pairwise to try to align our priorities. This worked especially well at company off-sites and quarterly planning cycles.

I've since made it into algorithm running in a [Google Sheet](https://docs.google.com/spreadsheets/d/1BYh9ZtEv4k7xoSXmtf1qCP8bYHBCZLEuTVHsTDPQM1M/edit?gid=2033972304#gid=2033972304). Now you can try it with your teams!