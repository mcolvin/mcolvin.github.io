---
layout: post
title: There’s models and then there’s inference
bigimg: /img/big-img/aldridge-2019-10-25-blog-post-banner.jpg
tags: [hypotheses, to explain or predict, model selection, parameter estimation, inference]
---

Post by [Caleb Aldridge](https://aldridgecaleb.github.io/).---This is a recent paper wirtten for a directed study course on the philosophy and application of estimation. The thoughts are my own and do not neccessarily reflect those of my lab. 

## Introduction

People communicate via models. We use similes and metaphors, words and expressions, tone and cadence, etc. to model our thoughts, reactions, and emotions. When we talk with one another we are modeling. My point is we’re all modelers. Only, like Kéry & Schaub (2012) point out, not everyone realizes they are a modeler. 

One group that would recognize themselves as modelers are ecologists. They have had a romance with statistics for hundreds of years, and it is only getting more passionate with age! The last couple of decades ecologists have seen massive improvements to the speed and power of computers, or as I like to call them modeling assistants. This has a allowed ecologists to fit evermore complex models to their systems, but even with the increased computing power some philosophical issues started to rear their ugly head. 

In the following I aim to be *extremely* brief in: (1) describing the constituent parts of a model and (2) compare and contrast the way Bayesians and Frequentists interpret models. (I will suspend my urge to further dichotomize “Frequentists” into their more proper groups: “Fisherians” and “Neyman–Pearsonians”).

## Models

Kéry & Schaub (2012) give one of the best answers to “what is a model?” anywhere. On page 24:
>[M]ost observable phenomena in nature are too complex for us to understand directly by simply staring at them, or rather, the system that has generated them is too complex, that is, affected by too many factors, too variable over space or time, and so on. So, explaining always requires simplifying things. Broadly, a model is nothing but a formal simplification of a complex system that we would like to explain or whose behavior we would like to predict.

Good models convey the big picture of a system to those reading them. Good modelers help filter the features that become the constituent parts of a model. Good modelers in ecology ask questions like: Does including this factor make sense biologically? Can we exclude one of these feature, as they are highly correlated? Does transforming this variable improve the model’s fit (or performance)? You might get the sense that modeling is not as exact as it may seem from  introductory statistical analysis texts. Indeed, modeling is much like a skilled trade, albeit with a steep learning curve. Good modelers see beauty and craft in the mathematics and graphs they compose.

Modeling is as much art as it is science (McCullagh & Nelder, 1989).

The linear model and its close relatives are perhaps the most influential tool in contemporary ecology. I doubt that no less than 50% of articles published by ecological journals in 2019 include a linear model of some sort. Linear models are used so much because they are simple. One part algebraic function plus one part probability distribution. It has been termed in at least these ways as well: systematic + stochastic; deterministic + random; and signal + noise. The systematic portion is the link (algebraic function) between the important features we are using to explain some response in our system. The random portion is the deviation in response from our algebraic function is due to unobserved, unknown, or perhaps many unaccounted features. However, the whole of the deviations can usually be describe by some shape (e.g., the bell curve). So, models help ecologists understand and, or predict responses in their system based on their functional link to features, but what is unknown can be “expected” by describing how an observation might deviated from our deterministic portion of the model. Aptly,

All models are wrong, but some are useful (Box; Kéry & Schaub, 2012).

## Inference

Whether a “Frequentist” or a “Bayesian” models, i.e., the way we link features and responses in our systems, are the same. What we do with the model when interpreting is a different story. As Link & Barker (2010) state, “The essential difference between Bayesian and frequentist philosophies is in the use of the term probability.’” Some key distinctions between the two approaches to inference:

1. P(y|H) vs. P(H|y), that is for classical inference we obtain the probability of the data, given the hypothesis and for Bayesian inference we obtain the probability of the hypothesis given the data.
2. Probability itself is a relative frequency in classical inference while in Bayesian inference it is a “degree of belief” in the likelihood of an event—I prefer degree of support.
3. Bayesian inference leverages prior knowledge with sample data when estimating parameters; classical inference only uses sample data.^1^
4. For Bayesians parameters can and should be interpreted as having a probability distribution (i.e., random). Frequentist inference sees parameters as fixed but unknown quantities.^2^

Bayesian analysis uses conditional and marginal probabilities to calculate the probability of an event, or hypothesis, given that another event, or data, has been observed. However, solving for Bayes rule in complex models involves high-dimensional integration which might be impossible to solve (Kéry & Schaub, 2012; Link et al., 2002). So, Markov chain Monte Carlo simulations are used to draw (as in pull) samples from an (or multiple) estimated distributions so that this distribution of drawn samples approximates the posterior (Kéry & Schaub, 2012; Link et al., 2002). This posterior distribution, keep in mind, is the probability of the parameter (expressed as hypothesis above in 1) given the data. We can then use summary statistics, i.e., a central tendency and spread, to describe the parameter of interest and the uncertainty around the central tendency value. This allows for interpretation to become: “I am 95% sure the parameter is between these intervals” vs. “Upon repeated sampling, 95% of the intervals would contain the parameter.” This become extremely more useful for ecologist and mangers. What’s more the ability (requirement) to included prior information into the analysis can help ecologists and managers learn as they move forward!

## Closing

This has been a crash course in modeling and inference, one that only skimmed the surface and breezed by the philosophy of science and statistics.

### References and Additional Readings

Ellison, A. M. (2004). Bayesian inference in ecology. Ecology Letters, 7 : 509–520. Gelman, A., Carlin, J. B., Stern, H. S., Dunson, D. B. Vehtari, A., & Rubin, D. B. (2014). Bayesian data analysis (3rd ed., pp. 165–195). Boca Raton, FL: CRC Press.

Hobbs, N. T. & Hooten, M. B. (2015). Bayesian models: A statistical primer for ecologists (pp. 209–229). Princeton, NJ: Princeton University Press.

Kéry, M. (2010). Introduction to WinBUGS for ecologists: A Bayesian approach to regression, ANOVA, mixed models and related analyses (pp. 1–5). Burlington, MA: Academic Press.

Kéry, M. & Schaub, M. (2012). Bayesian population analysis using WinBUGS: A hierarchical perspective (pp. 23–45). Waltham, MA: Academic Press.

Link, W. A. & Barker, R. J. (2010). Bayesian inference: With ecological applications (pp. 3–12). London, UK: Academic Press.

Link, W. A., Cam, E., Nichols, J. D., & Cooch, E. G. (2002). Of bugs and birds: Markov chain Monte Carlo for hierarchical modeling in wildlife research. Journal of Wildlife Management, 22 (2): 277–291.

McCullagh, P. & Nelder, J. A. (1989). Generalized linear models (2nd ed.). Boca Raton, FL: CRC Press.

Ward. E. J. (2008). A review and comparison of four commonly used Bayesian and maximum likelihood model selection tools. Ecological Modeling, 211 (1–2): 1–10.


Notes:  
^1^ One can use “weak” priors to essentially obtain the maximum likelihood estimate, like in classical stats, but with the added benefit of Bayesian interpretation of posterior. Side opinion: Link et al. (2002) use very poor language to label this approach, “Objective Bayes Models.”  
^2^ Bayesians, truthfully, may also see parameters as fixed but they treat them as random due to the uncertainty about the unknown parameter (Link & Barker, 2010; Kéry & Schaub, 2012).