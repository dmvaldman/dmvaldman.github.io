---
layout: post
title: Schizorationality
date: 2024-07-11
excerpt: Rationality is not the cure, it is the disease
image: schizorational/schizorational.webp
caption: Drawing taken from <a href=https://www.reddit.com/r/Weird/comments/1cjh912/woman_with_schizophrenia_draws_what_she_sees_on/ style="color:gray">Reddit</a>
---

I'm not rational or irrational, but a secret third thing. I call it Schizorationality. Schizorationality is the simultaneous maintaining of entire subsystems of belief in uncollapsed form. Schizorationalists are internally conflicted, can often be seen arguing against themselves, and are confused by the certainty of others. They are also devoutly rational. In fact, I claim that any serious undertaking of rationality leads to Schizorationality out of necessity.

(For definition's sake, by "rational" I will assume a Bayesian model: rational people associate a probability to their beliefs and update these probabilities against evidence according to [Bayes' rule](https://en.wikipedia.org/wiki/Bayes%27_theorem).)

Where rational people go astray is they think Bayes' rule leads to truth. Their mistake is to confuse a process for a destination. A careful reading of Bayes' rule will show it leads not to truth, but to discord! The polarization and incoherence we see in the world is not despite people's training in rational deduction, but because of it. Rationality is not the cure, you see, it is the disease.

Schizorationality offers a different persepective. It is perfectly consistent with Bayes' rule, but departs from rationality in its interpretation. Schizorationality is not interested in the convergence of belief to truth. Many behaviors ascribed as irrational by the rationalist become expected behavior to the Schizorationalist. A Schizorationalist is rarely surprised by the incoherence of the world. Paradoxically, rejecting truth may lead to a better model of reality (if only that was something they cared about).

## How I Stopped Worrying and Embraced Schizorationality

My journey to Schizorationality started, like many, from an errant belief. I used to think that a rational person, upon seeing evidence counter to their beliefs, would change their mind somewhat. I think many of us are seduced by this notion; it is so core to the rationalist mindset. Yet often we are met with counterevidence. Rationalists dismiss such behavior as irrational and thumb through a rolodex of cognitive biases to explain it away: motivated reasoning, confirmation bias, groupthink. *Sigh*, just more errant beliefs to me now.

But how can two people of opposing views see the same piece of evidence and further entrench themselves in their initial positions? It's as if, taken as a whole, they embrace contradiction and, taken separately, at least one of them doesn't care if their beliefs map onto reality at all! If you're nodding your head in agreement, you may be as surprised as I was to discover this behavior is perfectly accounted for by Bayes' rule.

The critical piece we often overlook is doubt. We can doubt the evidence, and we can do so justifiably by referring to other beliefs. Once doubt is in the picture, [Aumann's Agreement](https://en.wikipedia.org/wiki/Aumann%27s_agreement_theorem)---a saving grace for rationalists hoping for a convergence of belief---fails us[^Lederman], and rational thinking can rationally diverge[^Dorst].

"But I don't disbelieve evidence!", I hear you clamoring. Well, I doubt that. When a magician saws their stage assistant in half, do you believe more in the awesome power of magic? Surely not. The only thing you believe in more is that you're being tricked. You dismiss the evidence, and the more evidence you gather, the greater your dismissal. "Hey you!", I hear the magician say, "Come on stage. See for yourself! Let me rotate her around. Feel how sharp the blade is!" This accrual of evidence serves only to dig your heels deeper into preconception.

I can feel you coming up with justifications right now. Bayes at work, I'm afraid! Bayes' rule implies that if you believe in an alternate hypothesis more likely to account for the evidence, then you should believe it more than the hypothesis presented before you. Bayes' rule does not care what your beliefs are, whether they are "true" or not, only that you believe them! So when we doubt the magic and explain it away with speculations of a mechanism we can neither see nor hear nor touch, we are still following Bayes. When we doubt the magic by appealing to the specters of past experience, we are still following Bayes. If the magic is not happening on stage, then surely it is happening within our minds.

Let's take a more relevant example. How about a study from a prestigious institution linking global warming to human activity? Surely this will convince a skeptic! But a skeptic is not surprised by such evidence. You are simply trying to trick them. They know all too well that prestigious institutions are full of biased liberal academics spouting nonsense in their quest to suppress our individual liberties and secure more grant money. Skeptics have their own hypotheses, differing from yours, that account for the evidence but don't imply your conclusion. They are following Bayes, too.

--------------------

### Math Interlude (optional)

In more mathematical detail I will show how Bayes' rule leads to confirmation bias, but feel free to skip if you don't have the requisite background. To acquire such background, I recommend [this book](https://www.amazon.com/Probability-Theory-Science-T-Jaynes/dp/0521592712).

Let $c$ be some claim, for example, $c = $ "Global warming is caused by human activity" and let $\bar{c}$ be its opposite. You are met with some new evidence $e =$ "A study from Harvard linking global warming to human activity". However, you distrust the evidence and have an alternate hypothesis "Academics have a liberal bias" that accounts for the evidence but supports $\bar{c}$. Moreover, you believe in this alternate hypothesis more than you do that $e$ accounts for $c$

$$P(e|\bar{c}) > P(e|c)$$

Then by Bayes' rule,

$$
\begin{align*}
P(c|e) &= \frac{P(c) P(e|c)}{P(e)} \\
        &= \frac{P(c) P(e|c)}{P(e|c) P(c) + P(e|\bar{c}) P(\bar{c})} \\
        &< \frac{P(c) P(e|c)}{P(e|c) P(c) + P(e|c) P(\bar{c})} \\
        &= \frac{P(c)}{P(c) + P(\bar{c})} \\
        &= P(c)
\end{align*}
$$

Hence, upon seeing the article $e$ linking global warming to human activity, you think the claim global warming is caused by humans, $c$, is less likely! For a more thorough (and fun) treatment, see [chapter 5 of Jaynes](#fn:Jaynes)[^Jaynes].

--------------------

At this point, a rationalist may still be hopeful: all we have to do to recover truth is to disprove these nagging alternate hypotheses! Indeed this could work, but good luck trying. There's no reason to assume a skeptic won't summon alternate alternative hypotheses to disprove your disproof. It's natural to form lattices of self-supporting beliefs that are robust against attack[^Jern]. I did so myself when I was a rationalist, like when I attributed my beliefs in irrationality to my beliefs in motivated reasoning, confirmation bias, and groupthink. Once you accept evidence can be ambiguous, many of the biases we've come to see as deviations from Bayes' rule can in fact be modeled by it. See, for example, Beden's [Hindsight Bias is not a Bias](https://academic.oup.com/analysis/article-abstract/79/1/43/5032779) and Dorst's [Gambler's Fallacy is not a Fallacy](https://www.kevindorst.com/stranger_apologies/the-gamblers-fallacy-is-not-a-fallacy)---two tomes of Schizorational thought.

Rationalists often remark how living out Bayes' rule is hard work, so they are not surprised  many of us take cognitive shortcuts and fall prey to their traps. Rationalists believe this is the reason why there are so many contradictory beliefs in the world. Schizorationalists have an alternate explanation. Once there is any controversy in the picture, a Schizorationalist does not expect Bayes' rule to steer us toward agreement any more than they expect Darwinian evolution to steer life to a maximally fit creature. What they expect each to steer us toward is a dynamic system of minimaxed niches. Evolution's ecosystems are Bayes' echo chambers; its umwelts are ideologies. It is discord, not harmony, that the arc of Bayes' bends towards.

## How to Become a Schizorationalist

What to do? What to do? How to navigate a world operating under rational principles that is rife with tumult? Here's what a Schizorationalist has to say. A Schizorationalist embraces this diversity and sees it as the Gaian lifeforce latent in Bayes' rule. They look at rationalists as myopic pillagers trying to pave over biodiversity with one big parking lot. A Schizorationalist, in harmony with nature, is empathetic to this ecosystem. She asks, "What are these beliefs? What are these alternate hypotheses?" A Schizorationalist has [the scout mindset](https://en.wikipedia.org/wiki/The_Scout_Mindset).

At some point a Schizorationalist has to make a decision for herself. She is met with a conundrum. Able to justify almost any action, the question "What do I do?" is equivalent to "Who am I now?". Unlike a rationalist, there is nothing to say a Schizorationalist should be consistent with themselves from one moment to the next! They could be a 15th century Copernican today and a 22nd century Flat Earther tomorrow, each operating under Bayes' rule. The plight of empathy has always been indecision.

Here, there are several schools of Schizorationalty (many-worlds, pilot-wave, I don't have time to go into them all). The one I ascribe to is a nod to modern AI training. A Schizorationalist, in her purest form, is like a base language model. She contains all knowledge in existence and internally forms representations of any possible person. When you run such a model, all you get is unvarnished schizoid output. But now we do an [RLHF](https://www.anthropic.com/news/claudes-constitution) training step against a constitution---the principles we define externally and quite arbitrarily. Slowly the schizotic episodes become more stable and relatable---an identity emerges. The multitude of internal selves are still present, but are now accessed in an opinionated way. Streams of personas are rolled out, and from this frenzy of contradiction, a reward model plucks out "Who am I now?".

This is quite a departure from the behavior of rationalists. A rationalist has evolved from inside out. He starts from tabula rasa beliefs, and is led, experience by experience, to occupy a niche of thought. A society of rationalists, doing so in parallel against a diversity of experience, forms a landscape of incoherent ideologies, each laying claim on truth. A Schizorationalist inverts this model; she has evolved from outside in. Rather than starting tabula rasa, she starts from the landscape. Rather than being led to action via Bayes' rule, she chooses a Bayesian who acts. Rather than referring to beliefs taken as truths, she refers to principles chosen whimsically.

----------

[^Yud]: Yudkowsky, E. (2012). [The useful idea of truth](https://www.lesswrong.com/posts/XqynWFtRD2keJdwjX/the-useful-idea-of-truth). LessWrong.
[^Jaynes]: Jaynes, E. T. (2003). Probability theory: The logic of science. Cambridge University Press. Chapter 5. [(pdf)](http://www.hep.fsu.edu/~wahl/phy5846/statistics/jaynes/pdf/cc05e.pdf)
[^Jern]: Jern, A., Chang, K. K., & Kemp, C. (2014). Belief polarization is not always irrational. Psychological Review. [(pdf)](https://www.charleskemp.com/papers/jernck_beliefpolarizationisnotalwaysirrational.pdf)
[^Lederman]: Lederman, H. (2014) People with common priors can agree to disagree. The Review of Symbolic Logic. [(pdf)](https://philpapers.org/archive/LEDPWC.pdf)
[^Dorst]: Dorst, K. (2023) Rational Polarization. The Philosophical Review. [(pdf)](https://philpapers.org/archive/DORRPM-3)
[^Hume]: Hume, D. (1748) An Enquiry concerning Human Understanding, Section X, "Of Miracles". [(pdf)](http://philosophyfaculty.ucsd.edu/faculty/ewatkins/HUM4Texts/Hume-Miracles%2810%29.pdf)