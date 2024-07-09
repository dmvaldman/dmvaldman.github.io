---
layout: draft
title: Schizorationality
date: 2024-07-03
excerpt: Rationality is not the cure, it is the disease.
image: schizorational/schizorational.webp
caption: Drawing taken from <a href=https://www.reddit.com/r/Weird/comments/1cjh912/woman_with_schizophrenia_draws_what_she_sees_on/ style="color:gray">Reddit</a>
---

I'm not rational or irrational, but a secret third thing. I'm calling it Schizorationality---split rationality. Schizorationality is the simultaneous maintaining of entire subsystems of belief in uncollapsed form. I claim that when you embrace rationality to its fullest you are led to Schizorationality out of necessity.

For definition's sake, by "rational" I will assume a Bayesian model: rational people associate a probability to their beliefs and update these probabilities against evidence according to [Bayes' rule](https://en.wikipedia.org/wiki/Bayes%27_theorem). We can debate other models, but let's not.

Where rational people go astray is they take Bayes' rule for a path to truth. They talk a lot about the exercise of mapping beliefs onto objective reality.[^Yud] Their mistake is to confuse a process for a destination. I'm here to convince you that a close reading of Bayes' rule shows it leads not to truth but discord! For all the polarization and incoherence we see in the world, rationality is not the cure, it is the disease.

It's important to state that Schizorationality is perfectly consistent with Bayes' rule. Its only departure from rationalism is its interpretation. A Schizorationalist rejects the goal of mapping one's beliefs onto reality because it is not interested in the convergence of belief to truth. Rather, it only asks us to map our beliefs onto the beliefs of others and embrace the ensuing discord. This reframing has ripple effects. As we will see, many behaviors ascribed as irrational by the rationalist become expected behavior to the Schizorationalist. A Schizorationalist is rarely surprised by the incoherence of the world. Paradoxically, rejecting truth may lead to a better map of it, if that's something you care about.

## How I Stopped Worrying and Embraced Schizorationality

My journey to Schizorationality started, like many, from an errant belief. I used to think that a rational person, upon seeing evidence counter to their beliefs, should change their mind somewhat. I think many of us think this way; it is so core to the rationalist mindset. Yet often we are met with counterevidence. Rationalists dismiss such behavior as irrational and thumb through a rolodex of cognitive biases to explain it away: motivated reasoning, confirmation bias, group think. *Sigh*, just more errant beliefs to me now.

But how can two people of opposing views see the same piece of evidence and further entrench themselves in their initial positions? It's as if, taken as a whole, they embrace contradiction and, taken separately, at least one of them doesn't care if their beliefs map onto reality at all! If you're nodding your head in agreement, you may be as surprised as I was to discover this behavior is perfectly accounted for by Bayes' rule.

The critical piece we often overlook is doubt. We can doubt the evidence, and we can do so justifiably by referring to other beliefs. Once doubt is in the picture, [Aumann's Agreement](https://en.wikipedia.org/wiki/Aumann%27s_agreement_theorem)---a saving grace for rationalists hoping for a convergence of belief---fails us[^Lederman], and rational thinking can rationally diverge[^Dorst].

"But I don't disbelieve evidence!", I hear you clamoring. Well, I'm skeptical of that. When a magician saws their stage assistant in half, do you believe more in the awesome power of magic? Surely not. The only thing you believe in more is your own gullibility. You dismiss the evidence, and the more you gather, the greater your denial. "Hey you!", I hear the magician say, "Come on stage. See for yourself! Let me rotate her around. Feel how sharp the blade is!" This accrual of evidence serves only to dig your heels deeper into preconception.

I can feel you coming up with justifications right now. Bayes at work, I'm afraid! Don't worry, this is perfectly normal, and (thank heavens!) rational. Bayes' rule implies that if you believe in an alternate hypothesis more likely to account for the evidence, then you should believe it more than the hypothesis presented before you. Bayes' rule does not care what your beliefs are, whether they map onto reality or not, only that you believe them! So when we doubt the magic and explain it away with speculations of a mechanism we can neither see nor hear nor touch, we are still following Bayes. When we doubt the magic by appealing to the specters of past experience, we are still following Bayes. If the magic is not happening on stage, then surely it is happening within our minds.

Let's take a more relevant example. How about a study from a prestigious institution linking global warming to human activity? Surely this will convince a skeptic! But a skeptic is not surprised at all by such evidence. They believe all too well that prestigious institutions are full of biased liberal academics spouting nonsense in their quest to suppress our individual liberties and secure more grant money. Skeptics have their own hypotheses, different than yours, that account for the evidence but don't imply your conclusion. They are (praise be!) following Bayes, too.

--------------------

#### Math Interlude (optional)

I'm going to show how Bayes' rule can lead to confirmation bias, but feel free to skip if you don't have the requisite background. To acquire such background, I recommend [this book](https://www.amazon.com/Probability-Theory-Science-T-Jaynes/dp/0521592712).

Let $c$ be some claim, for example, $c$ = "Global warming is caused by human activity" and let $\bar{c}$ be its opposite. Now you are met with some new evidence $e =$ "A study from Harvard supporting $c$". However, you distrust the conclusion and have an alternative hypothesis "Academics have a liberal bias" that accounts for the evidence but supports $\bar{c}$ rather than $c$. Moreover, you believe in this alternative hypothesis more than you do that $e$ accounts for $c$

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

Upon seeing the evidence $e$, you think $c$ is less likely, even though $e$ is evidence for $c$! For a more thorough (and fun) treatment, see Chapter 5 of Jaynes[^Jaynes].

--------------------

At this point, you may still be hopeful: all we have to do to recover truth is to disprove these silly alternate hypotheses! Indeed this could work, but good luck trying. There's no reason to assume the skeptic won't summon alternate alternative hypotheses to disprove your disproof. It's natural to form entire lattices of self-supporting beliefs that are robust against attack[^Jern]. I did so myself when I was a rationalist, attributing the irrationality I saw to biases like motivated reasoning and group think. Once you assume evidence can be ambiguous, many of the biases we've come to see as deviations from Bayes' rule can in fact be modeled by it. See, for example, Beden's [Hindsight Bias is not a Bias](https://academic.oup.com/analysis/article-abstract/79/1/43/5032779) and Dorst's [Gambler's Fallacy is not a Fallacy](https://www.kevindorst.com/stranger_apologies/the-gamblers-fallacy-is-not-a-fallacy)---two tomes of Schizorational thought.

Now, I'm not saying irrationality does not exist---there are plenty of violations of Bayes' rule---only that irrationality is often not what accounts for the division we see. Consensus is an exceptionally rare occurrence under Bayes' rule, bestowed upon only the most banal of facts. For claims with any trace of controversy we should not expect rationality to steer us toward agreement any more than we should expect Darwinian evolution to steer a microbe toward a universally fit creature. What each steers us toward is a dynamic system of minimaxed niches. Evolution's ecosystems are Bayes' echo chambers; its umwelts are ideologies.

## How to Become a Schizorationalist

What to do? What to do? How to navigate a world operating under rational principles that is rife with tumult? Here's what a Schizorationalist has to say. A Schizorationalist embraces this diversity and sees it as the Gaian lifeforce latent in Bayes' rule. They look at rationalists as myopic pillagers trying to pave over all this biodiversity with a giant parking lot. A Schizorationalist, in harmony with nature, is empathetic to this ecosystem. She asks, "What are these beliefs? What are these alternate hypotheses?" as if picking up a curious sea shell. A Schizorationalist has [scout's mindset](https://en.wikipedia.org/wiki/The_Scout_Mindset).

At some point a Schizorationalist has to make a decision for herself. She is met with a conundrum. Able to justify almost any action, the question "What do I do?" is equivalent to "Who am I now?". Unlike a rationalist, there is nothing to say a Schizorationalist should be consistent with themselves from one moment to the next! They could be a 15th century Copernican today and a 22nd century Flat Earther tomorrow, each operating under Bayes' rule. The plight of empathy has always been indecision.

Here, there are several schools of Schizorationalty (many-worlds, pilot-wave, I don't have time to go into them all). The one I ascribe to is a nod to modern AI training. A Schizorationalist, at her purest form, is like a base language model. She contains all knowledge in existence and internally forms representations of any possible person. When you run such a model, all you get is unvarnished schizoid output. But now we do an [RLHF](https://www.anthropic.com/news/claudes-constitution) training step against a constitution---the principles we define externally and quite arbitrarily. Slowly the schizotic episodes become more stable and relatable---an identity emerges. The multitude of internal selves are still present, but are now accessed in an opinionated way. Streams of personas are rolled out, and from this frenzy of contradiction a reward model plucks out "Who am I now?".

This is quite a departure from the behavior of rationalists. A rationalist has evolved from inside out. He starts from tabula rasa beliefs, and is led, experience by experience, to occupy a specialized niche of thought. A society of rationalists, doing this in parallel against a diversity of experience, forms a landscape of incoherent ideologies. A Schizorationalist inverts this model; she has evolved from outside in. Rather than starting tabula rasa, she starts from the landscape. Rather than being led to action via Bayes' rule, she chooses a Bayesian who acts.

----------

[^Yud]: Yudkowsky, E. (2012). [The useful idea of truth](https://www.lesswrong.com/posts/XqynWFtRD2keJdwjX/the-useful-idea-of-truth). LessWrong.
[^Jaynes]: Jaynes, E. T. (2003). Probability theory: The logic of science. Cambridge University Press. Chapter 5. [(pdf)](http://www.hep.fsu.edu/~wahl/phy5846/statistics/jaynes/pdf/cc05e.pdf)
[^Jern]: Jern, A., Chang, K. K., & Kemp, C. (2014). Belief polarization is not always irrational. Psychological Review. [(pdf)](https://www.charleskemp.com/papers/jernck_beliefpolarizationisnotalwaysirrational.pdf)
[^Lederman]: Lederman, H. (2014) People with common priors can agree to disagree. The Review of Symbolic Logic. [(pdf)](https://philpapers.org/archive/LEDPWC.pdf)
[^Dorst]: Dorst, K. (2023) Rational Polarization. The Philosophical Review. [(pdf)](https://philpapers.org/archive/DORRPM-3)