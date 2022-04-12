---
layout: post
title: Wittgenstein and the Semantics of Language Models
date: 2024-05-01
excerpt: The words that come out of a language model are not like the ones that go in.
image: semantics/penrose_16_9.jpg
---

A definition of semantics has a storied history marked by centuries of debate. Philosophers from Putnam to ___ have argued whether meaning refers to states of our minds, or to things out in the world. Does meaning have something to do with truth, or simply degrees of belief? Even Wikipedia is at odds with itself; its article for [semantic internalism](https://en.wikipedia.org/wiki/Semantic_internalism) redirects to its article for semantic externalism. 

On a definition for meaning, Noam Chomsky once said, "It's a matter of choice. You define a technical notion in context of an explanatory theory, you don't just define a technical notion out in space. So let's ask what's the explanatory theory in which we pronounce meaning... and then we'll ask whether that theory is a sensible theory."

For this essay we choose to follow Wittgenstein. In _Philosophical Investigations_, Wittgenstein writes "The meaning of a word is its use in the language." Rather than meaning being about reference, we look instead to usage. Let's see how to apply this definition within the framework of language models.

## Meaning à la Wittgenstein

A language model (LM) is an algorithm that takes a sequence of words as input and generates new words as output. Mathemetically, given a sequence of words $$w_{1},\dots ,w_{k}$$ called a **prompt**, an LM assigns a probability $$P(w \vert w_{1},\dots,w_{k})$$ to each possible next word $$w$$. We denote $W^k$ as the set of all prompts of length $$k$$ and call this **prompt space**.

This definition can be reinterpreted to provide a definition of a **word** given a language model. By considering $w$ as a fixed parameter, we can consider the likelihood $$L_w$$ of any prompt

$$L_w(w_{1},\dots ,w_{k}) = P(w \vert w_{{1}},\dots ,w_{k}).$$ 

For example, the word "Apple" may have a high likelihood value around the prompts "Sally took a bite out of the juicy red " or "The quarterly earnings of US tech giant ", and a low likelihood value around the prompt "The longest river in Africa is ". 

For a given language model,  $$L_{\text{apple}}$$ is some very complicated distribution in prompt space. The crucial point is that this likelihood function encodes all potential _uses_ of a word. Following Wittgenstein, the **meaning** of $w$ is $L_w$. 

## A Geometry for Prompt Space

We have a collection of likelihood functions $\{L_w\}_{w \in W}$ for every word $w$ in our vocabulary $W$. We can use these to compare words to each other. To do so, we first need to define a topology and metric in prompt space.

One way to do this is to consider the likelihood regions 

$$R_{w,\alpha} = \left \{(w_1, \ldots, w_k) : L_w(w_1, \ldots, w_k) > \alpha \right \}.$$

These are subsets of $W^k$ consisting of all prompts the LM would likely (with probability greater than $\alpha$) complete with $w$. The choice of $\alpha$ won't be important for the rest of the essay, so we omit it from the notation and refer to $R_{w,\alpha}$ as $R_w$.

Since every prompt given to the LM results in some word, the collection of sets $\{R_w\}_{w \in W}$ defines an open covering of prompt space which can generate a topology for $W^k$. There is a natural measure of these sets which is its cardinality, and this allows us to define a notion of distance between words.

### Semantic Distance

If the language model is deterministic (e.g., GPT with temperature 0), then the collection of likelihood regions is a disjoint set, i.e., a partition of prompt space. Here word definitions would be "disjoint"; there would be no synonyms, no abbreviations, grammatical contractions, etc. 

Once a language model is non-deterministic, there will be many overlapping sets. Overlap represents ambiguity: more than one word could reasonably complete a given prompt. The greater the overlap, the more the words are semantically similar.

We can define the **semantic distance** $d$ between words $w_1, w_2$ as 

$$d(w_1, w_2) = \frac{ \|R_{w_1} \space \cap \space R_{w_2} \|}{ \|R_{w_1} \space \cup \space R_{w_2} \|}.$$

Set operations on likelihood regions should also be semantically meaningful as they can reveal nuances between words. Intersections reveal commonality, symmetric differences reveal subtle distinction. Boolean operations are able to pick apart semantics and stitch them back together.

### Interpretability

Thus far we are considering a language model as a blackbox, defining meaning only based on its input and output. How does this help us interpret what is happening *within* the LM?

To interpret the mechanisms in an LM it would help to start with something semantically meaningful and observe how the LM manipulates it. Individual words and prompts are not semantically meaningful by themselves, but likelihood regions are. One approach for interpretability could be to statistically compare how likelihood regions flow through the LM. Statistical distinctions in the LM should reflect semantic distinctions.

### Symbol Grounding and Intentionality

> To me, Chinese writing is just so many meaningless squiggles. 
*Searle*

> Each word tastes of the context and contexts in which it has lived. 
*Bhaktin*

To a language model, words are represented numerically as lists of numbers. Some models start with words as one-hot encodings, others use learned embeddings. Either way, the problem of seeking semantic content can be distilled to the question: how can lists of numbers _mean_ anything? 

I believe this dilemma hinges on a false equivalence: that the words inputted to a language model are like those it outputs; afterall, both are represented as lists of numbers. However, the output has a secondary interpretation as as likelihoods of prompts. Whereas words that are the input are meaningless symbols, the words that are the output have meaning because they have reference. Likelihoods are the referents of these lists of numbers.

So though the inputs to LMs may be meaningless squiggles and squoggles, the outputs are grounded and intentional. What they are grounded in may not be what humans ground language in, but they are grounded nonetheless.

