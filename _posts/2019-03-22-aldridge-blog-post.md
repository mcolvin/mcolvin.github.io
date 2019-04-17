---
layout: post
title: Design and Decisions, Part II
subtitle: Using crunched numbers in decision support
# bigimg: /img/big-img/aldridge-2019-03-22-blog-post-banner.png
tags: [experimental design, decision trees, structured decision making]
---

Post by [Caleb Aldridge](https://aldridge.github.io/).---
In my last [blog post](https://mcolvin.github.io/2019-01-25-aldridge/) I 
discussed modifying a simple experimental design to one slightly more 
complicated but allowed more alternatives in herbicide choice. (If you 
haven't read it, now's a good time--much of the material ahead relies on 
part I). I also alluded to budget and coverage (ha). These are important 
elements in deciding which herbicide to choose to control the invasive. 


Let's simplify the problem a little, so we can concentrate on why 
considering decision elements in the design of experiments is important. 
I'm going to focus on one fundamental objective, increase suitable 
habitat, and its two means objectives, maximize percentage dead stems 
per meter-squared and maximize area treated (ha). Let's also assume that 
$500 (USD) has been allocated for the purchase of herbicide, so we'll 
use the full amount. 


Recall from our experiment that we had two herbicides (Herbicide 1 & 2) 
at two concentration levels (Suggested and Below) we compared. We knew 
that the two herbicides may not have equal effectiveness, and we assumed 
this was even more the case when they were diluted. But we also knew 
that the below suggested concentration treatments would likely give us 
more coverage (area treated). The coverage area is important because 
we've surveyed about 90 ha where the invasive grass is growing. We'd 
like to get at least 100 ha of coverage, but because each herbicide is 
sold in different volumes were uncertain if we will meet our 100 ha 
goal. 


From our experiment we were able to determine probabilities for the 
three outcomes of percentage of dead stems per meter-squared. For 
Herbicide 1 Suggested the probabilities were: 0.02 for = 60%, 0.58 for 
61-79%, and 0.40 for = 80%. Probabilities for other treatments were: 

* Herbicide 1 Below = 0.10, 0.70, and 0.20;  
* Herbicide 2 Suggested = 0.20, 0.70, and 0.10;  
* and Herbicide 2 Below = 0.45, 0.50, and 0.05, for = 60%, 61-79%, and = 80%, respectively.  

We also placed probabilities on above or below 100 ha coverage. For 
Herbicide 1 Suggested we gave it equal chance (0.50-0.50), Herbicide 1 
Below 0.65 > 100 ha and 0.35 < 100 ha, Herbicide 2 Suggested 0.60 > 100 
ha and 0.40 < 100 ha, and for Herbicide 2 Below we assigned 
probabilities of 0.70 and 0.30 for > 100 ha and < 100 ha, respectively. 


We then valued the outcomes of percentage of dead stems per 
meter-squared and coverage. We did this on a scale of 1 to 9, 1 being 
the least valuable outcome and 9 being the most valuable outcome. The 
dead stems outcome of = 60% was valued at 1, 61-79% as 7, and = 80% as 
9. The coverage outcome of > 100 ha was valued at 9 and < 100 ha was 
valued at 3. The 'value' is subjective but should be consistent with the 
management objectives. There are other was that are less subjective but 
suffice this method in our example. We can then map the values and 
probabilities for each herbicide treatment (decision) in a tree. If we'd 
like to know the probabilities of each outcome, we can leave out choice 
of herbicide as equally uncertain (Fig. 1). But if we make the herbicide 
node a decision node the herbicide with the highest chance of a desired 
outcome (i.e., value) will be highlighted (dark green and bold lines; 
Fig. 2). 



Figure 1. Decision tree with uncertainty in herbicide choice---probability of outcomes are given in blue next to terminal (green) triabgles.


Figure 2. Decision tree with herbicide node as decision node. Other branches have been folded for convenience and probability of outcomes are in blue next to green triangles. 

### Take-home points
Experiments being used to solve problems should think about the possible 
decisions to be made once the experiment is included. Decisions about 
what to do aren't as simple as pick the one that was statistically shown 
to be most effective (highest proportion of in = 80% dead stems bin). 
Decisions need to consider objectives (i.e., herbicide effectiveness in 
killing invasive grass AND coverage to maximize suitable habitat) and 
constraints (i.e., volume of each herbicide treatment the allocated 
budget can afford). These can be considered before the experiment takes 
place--it just takes a little more planning. You can also imagine how 
quickly decision in natural resource management can become really 
complex; we've only looked at a simple example and it was still pretty 
hairy... 

 If you liked this post and want to learn more about the things our lab 
does please shoot us an email! 
