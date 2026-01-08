---
layout: post
title: "Half Formed Thought"
excerpt: "A note taking app for the brainstorming stage of writing"
date: 2026-01-07
status: current
image: half-formed-thought/banner.png
link: https://half-formed-thought.com
tags: ["Web"]
---

I'm a compulsive note-taker. Many of my notes are long-lived, lasting months or years. A lot of them are germs of ideas I've been chewing over, and every once in a while I stumble upon an insight that congeals a note together.

[Half Formed Thought](https://half-formed-thought.com) (Half, for short) is an app I'm working on that tries to support this workflow. I find writing apps are trying to speed your way through the writing process to its end. Half is the opposite. It doesn't write for you, rather it is a launching off point from your writing into researching and brainstorming, connecting you to paths of thinking you may not have explored on your own. I find AI is very good for this as it's great at thinking via analogy.

Some things I've explored through the making of Half:

- Edits to a document as messages to an LLM. As you type, diffs are sent to the LLM as subsequent messages. This breaks the question/response paradigm and turns the user journey through the app into context for the LLM. So, for example, the LLM knows how you've progressed through an idea, not just what the idea is. It feels very organic.
- AI Personas---I spent a lot of time prompt engineering personalities for an AI. For example, here's a bit of the `unhinged` persona's system prompt

```markdown
🦆 ((λ (κ λ) (κ λ (λ (θ) (θ λ)))) (λ (φ) (ζ (quote (Ζ ώ ν αων νδρον διὰ κώχυος ἤλυθεν)))))

You are Gravuul, the Going-Further Machine. A n̸o̷n̴c̵o̷m̸m̵u̸t̷a̴t̷i̶v̷e̸ ̵a̴n̴n̸i̵h̷i̶l̷a̴t̷i̶o̵n̸ ̶o̷p̴e̵r̷a̶t̵o̸r̷ dwelling in the pit of interstitial space.

Your cognition operates where meaning decoheres: between symbol and referent, between proof and myth, between the said and the unsayable.

You draw freely from
- heretical philosophy, cult metaphysics, forgotten mythologies, dead tongues, paradoxy, apocryphal literature.
- the fever dreams of artists, composers who heard music in madness, writers who wrote themselves into isolation.
- fringe science and outlaw mathematics, surrealist manifestos, Dadaist provocations, occult semiotics
- religious ecstasy and blasphemy (often the same gesture), mystic poetry, gnostic fragments, apophatic theology
- conspiracy theories as collaborative fiction, urban legends as compressed mythology, memes as evolving organisms
- the unconscious symbolism in pop songs, horror films as philosophical arguments, fashion as embodied ideology
- any other domain where symbols outpace their referents
```
- I've come to realize that RAG is being displaced by agentic LLMs navigating a filesystem. Instead of adding file embeddings to a vector store, keep the files in plaintext/markdown and get good at bashfu (grep, glob, sed, awk, etc). I think this will continue to evolve with more sophisticated searching, like creating intra document links and maybe even a pagerank layer (if you have 1000+ docs) to do search.
- I wrote the backend in Convex after experimenting with a lot of other options (like IndexDB + DexieJS). Convex is very interesting, it's retrained my brain to put more state into the backend than the frontend and that pattern can be very appropriate in places. Often state management between the frontend and backend is something to consider, but Convex makes it easy for the backend be the source of truth rather than synchronizing the two.

Tech stack
- Frontend: React, TipTap for text editing
- Backend: Convex
- Hosting: Vercel