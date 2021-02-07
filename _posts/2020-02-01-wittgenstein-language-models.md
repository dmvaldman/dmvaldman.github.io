---
layout:	post
title: "Wittgenstein and Interpreting Language Models "
date: 2020-02-01
excerpt: "A new research direction for interpretibility of language models."
---

>'Meaning is use.' 
*Wittgenstein*

A definition of semantics has a rich and storied history of which there has never been consensus. Are you a semantic externalist like Kripke or Putnam, an internalist like Chomsky and Davidson? [More examples] Even Wikipedia is confused, as the article for semantic internalism actually redirects to the article on semantic externalism (but perhaps this confusion is a revelation of its position). 

This confusion is unfortunate because semantics seems critical to interpretability of language models. To interpret an algorithm is to explain how its rule-based manipulation of symbols can represent "reasoning". The moment we do this we are endowing meaning to these processes, and specifically meaning to words. So to proceed with interpretability we should decide on a definition for semantics. We should choose a philosopher. 

Enter Wittgenstein.

Wittgenstein said "The meaning of a word is its use in the language." Where other definition of meaning hinge on ascribing words to references to other things (intentionality), either in the mind, or to something out in the world, Wittgenstein ignored reference completely. Meaning is simply usage. As Wittgenstein says “Don’t think, but look!” Great, let's do that. 

## Definition of Wittgenstein's Meaning in Language Models

A language model (LM) is a probability distribution over a sequence of words. Given a sequence of words (a prompt) of length *k*, 
$$w_{1},\dots ,w_{k}$$, an LM assigns a probability $$P(w_{k+1}|w_{{1}},\dots ,w_{k})$$ for the next word $$w_{k+1}$$ given the previous ones. More than assigning a probabilty, the LM typically selects the word with greatest probability. Let $W$ be the space of all words in the language. We define "prompt space" $$W^k$$ to be the set of all sequences of words of length $$k$$. Now we can describe an LM as a map from $$f: W^k \rightarrow W$$. Prompts go in, words come out.

Now we ask the question: what are all prompts that result in a given word prediction? In other words, what is the inverse, or preimage of a word? As the LM is a many to one function, the preimage is a set in prompt space. Hence we can associate each word $$w$$ the set $$f^{-1}(w) \subset W^k$$. For example, the preimage of "Apple" may include the prompt "Sally ate the red" and also "The quarterly earnings of tech giant" or "that rhymes with Snapple is" and probably lots of noise that makes no sense whatsoever [non-robust features].

The important point is that the preimage represents all the uses of the word according to the language model. This is Wittgenstein's definition of semantics. The meaning of $$w$$ is $$f^{-1}(w)$$.

### The Algebra of Prompt Space

If the language model is deterministic (e.g. GPT with temperature 0), then the collection of preimages, $\{f^{-1}(w)\} \space \forall w \in W$, is a disjoint set whose union is all of prompt space, i.e., it is a partition of prompt space. If language were deterministic, there would be no ambiguity. All sentences would have a precise "next word". The strange conclusion here is that words wouldn't have any relationship to each other, their definitions would be completely "disjoint". 

Once the language model is non-deterministic, all hell breaks loose. There will be tons of overlapping sets, but still their union would be all of prompt space. Overlap in sets represents nuance: more than one word could reasonably complete a given prompt. But this allowance for subtlety lets us compare words to each other. For example, if the intersection over union of two preimage sets is close to 1, their associated words should be semantically similar. We can define the distance $d$ between words $$w_1, w_2$$ as 

$$d(w_1, w_2) = \frac{\left|f^{-1}(w_1) \space \cap \space f^{-1}(w_2)\right|}{\left|f^{-1}(w_1) \space \cup \space f^{-1}(w_2)\right|}.$$

This allows us to compare words semantically.

We can also think about the pre-image for a pair of words $$(w_1, w_2)$$. This would be all prompts that when the language model is iterated twice would produce these next two words in succession. However, $$f^{-1}(w_1, w_2) = f^{-1}(w_1) \cap f^{-1}(w_2)$$ because we are looking for all prompts that produce $$w_2$$, $$f^{-1}(w_2)$$, from the set of prompts which end in $$w_1$$, $$f^{-1}(w_1)$$ (this isn't quite exact because one must account for a shift in the context-window).

$$f^{-1}(w_{k+1}) = \cup_{f(w_1, ..., w_k) = w_{k+1}} (w_1, ..., w_k) = f^{-1}(w_1, ..., w_k) = f^{-1}(w_1) \cap f^{-1}(w_2) \space \cap... f^{-1}(w_k)$$



Pre-image of two words as intersection. S(A and B) ~ S(B) int S(A) but is A AND B is represented by its own word, there should be some internal consistency. S(Single man) and S(bachelor), so S(bachelor) ~ S(single) int S(man). This involves our input but can be defined purely consistently by breaking up prompt space.

Previous definitions of semantics may include word embeddings, but this associates words with vectors and assumes some sort of linear embedding space. I think it is more useful to associate words with sets, and define an algebra over prompt space, rather than create some new embedding space.

Compare to corpus itself. Compare LMs to one another. 

Creativity. Sets overlap in meaningful but long-range

Fuzzy sets, membership function is logistic equation.

Subtly important overlaps. Freedom and liberty. Wouldn't the set difference have to do with the semantic distinction. What other words overlap this semantic distinction. Can we define words in terms of compound words this way. 

Can we bUild sequences of sets that converge to a given set, and use this to define sequences of language models. Isn't this the same as two people talking to each other, live learning, and coming to consensus? Maybe that's how we train them. They talk to one another and we minimize this measure. 

How does it help us interpret? We can look at the action on the pre-image sets in bulk. Follow the meaning, and the meaning is not in the embedding. 

Induced metric of kl.divergence to compare elements of prompt space