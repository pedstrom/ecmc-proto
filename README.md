# Proto Challenge for ECMC

Hello, and thank you for taking the time to look at this code. There is a lot of commentary throughout this repository and I hope you find it helpful in understanding my thought processes. Before we jump into it, I'd like to thank [Kay Ehni](https://github.com/ehnik/binary-parser) for her incredibly succinct Ruby example (though I think you got Q5 wrong ... sorry!), and [Rob Simmons](https://bitbucket.org/robsimmons/adhoc_homework/overview) for posting your results - this was exceptionally helpful validation! I'd also like to thank [Ad Hoc](https://github.com/adhocteam/homework/tree/master/proto) for designing and publishing this excellent challenge.

## About Me

Hi! I'm Peter Edstrom. I builds teams to solve complex software problems. I see myself as a straightforward and methodical team player. I have about 20 years of software experience ranging from UX to data science to machine learning. As an engineering leader, I work to actively bring about positive change in the organizations I'm working with.

Of course I have a [LinkedIn Profile](https://www.linkedin.com/in/peteredstrom/), and if you'd like to get ahold of me, the best way is by email: [peter@edstrom.net](mailto:peter@edstrom.net). 

## Items of Interest

With the preliminaries out of the way, let's start unpacking this challenge. I've organized the code as follows:

* [byte-reader/](byte-reader/) - These are the original challenge files, as presented to me.
* [02-proto.Rmd](02-proto.Rmd) - The R Markdown Notebook that contanins my thought process while coding the solution, as well as the final code. 
* [02-proto.pdf](02-proto.pdf) - This includes the code, as well as the execution results from RStudio. There's an HTML version as well, but if you are not viewing this locally [02-proto.nb.html](02-proto.nb.html) may show you the html source instead of a rendered page. I'd recommend downloading the file and open the local copy in your browser of choice.
* [Commits](https://github.com/pedstrom/ecmc-proto/commits/master) - Not only do you get all of my commentary in the aformentioned notebook, but you get all of my commit messages as well!

## The Choice to use R Project for Statistical Computing

First and formost, I should note that there was no requirement to choose a specific language. Python, Ruby, JavaScript, and Java were called out as possibilities, but I chose to address this challenge using [R Project](https://www.r-project.org).

There are a few reasons for this choice: 

* Data science is an active interest of many people right now, and the scientists seem to favor either R or Python languages.
* I was _not_ able to find a pre-made solution in R through googling.
* I didn't have any idea if R had binary operators that could handle this challenge, and I was curious to find out.
* Notebooks - a technology available in R and Python (plus a few others) - is an excellent way to document a thought process.
* And I like R. It's been around for a long time ( [24 years!](https://en.wikipedia.org/wiki/R_(programming_language)) ), and I feel it is an underappreciated tool given the power it brings to processing data.

## Analysis Before Writing Code

Before you ever write a single line of code, it's best to think through the problem ahead of time and conduct some research. I'm not talking about the _architecture_ of the solution, but the _strategy_ in which the architecture will be decided. These can be found in questions like: How am I allowed to solve this problem? If I find another solution I can copy & paste, is that considered cheating? What resources are at my disposal? Can I pair-program on the solution? What constraints exist?

Let's talk about the constraints and then do some research on previous solutions.

#### Constraints

* I was given 6 calendar days to complete the challenge. I could request additional time if needed.
* My primary computer for the last 15 months has been an iPad Pro. This has been a fascinating experiment that I’d love to tell you about at some point. However the salient point here is that while the iPad has been sufficient for more than 90% of my computing tasks, coding is one area that it falls short. I needed to make a shift to address the coding challenge.
* My secondary computer is an aging 2011 iMac. This is a shared computer used heavily by all of the other members of my family.

#### Previous Solutions

You might ask why I am even considering searching Google for previous solutions - that may be construed as cheating or even plagerism! But before we go any further, let me assure you that I have no intention of cheating. I fully intend to write my own code, and indeed, have already done so. The solution I have put forward is nothing like any of the published solutions.

But software development when done well, is a collaborative effort. I am currious about other approaches. But I am also aiming to answer a simple question: If the _answers_ are all that matter, are those answers available in a trustworthy form without writing any code? I found:

* a potential [Elixir solution](https://gist.github.com/mattvonrocketstein/4c1a573015fcdc7502b05a65eeec6265).
* a potential [C solution](https://bitbucket.org/robsimmons/adhoc_homework/src/3a4c6e0186485beb5de7002b15cb9c25706989c2/proto/?at=master) which also have [final resuts](https://bitbucket.org/robsimmons/adhoc_homework/overview) published.
* a potential [JavaScript solution](https://gist.github.com/bradbaris/b8f3b4da14f0c1b3a2816113ba18410c).
* a potential [Ruby solution](https://github.com/ehnik/binary-parser).

Notice I'm saying "potential". None of these are guarenteed to work, nor are they guarenteed to have correct answers. 

Of the 4 solutions, only 1 (the C solution) had published resuts. I decided to corroborate those results by locally running the Ruby solution. I downloaded the code [01-sample-proto.rb](01-sample-proto.rb) and ran it with my local installation of Ruby (`version 2.3.3p222`). 

The results were: 

```
{:question_1=>18203.69953340208, :question_2=>10073.359933036814, :question_3=>10, :question_4=>8, :question_5=>248.58493153382494}
```

These results match the C solution with a few exceptions:

* The ruby code appears to have more precision on question 1 and 2.
* They differ on the answer to question 5 (0 vs 249)

Given these two samples, I'm inclined to believe that we have found a answers to the initial 4 questions. Using only the digits that are in agreement:

* What is the total amount in dollars of debits?  Answer: **18203.699533**
* What is the total amount in dollars of credits? Answer: **10073.359933**
* How many autopays were started? Answer: **10**
* How many autopays were ended? Answer: **8**

I’d like to refine the first two answers slightly. The challenge README.md _does_ specify that the amounts are in dollars. So it would be appropriate to display the results in dollars, and I'd favor the traditional format in the United States: include the unit “$”, a comma separators for thousands, and round to the nearest penny. So:

*	Debits? **$18,203.70**
* Credits? **$10,073.36**

But then again, both coding examples may be wrong. I find it suspect that any amount recorded in dollars would have precision past the hundredths place.

There are instances where fractional pennies are important (for example, the cost of a gallon of gas) but it is equally likely that the fractional pennies are simply an artifact of translating a base-10 number into a base-2 representation. It might be more appropriate to round each amount as it is extracted from the data file - prior to any calculations - instead of after calculations are completed.

#### Previous Solution Summary

To sum up where we are right now in the thought process:

* Rounding questions aside, I have pretty strong confidence that we have correct answers for the first 4 questions.
* There are two contending answers for the 5th question.
* I have not yet written a single line of code.

#### Ad Hoc

During my research, I found that the original authors of the code challenge was from a company called Ad Hoc. They provide a [quick tip](https://github.com/adhocteam/homework#a-quick-tip) worth including: _“We want to see how you approach the problem, understand what's being asked, and solve it. We tend to favor solutions that are simple, elegant, and efficient. Submit a solution as if you were giving it to a colleague for code review.”_

This seems like a good approach, and one that I'll be thinking about as I create my [solution in R](02-proto.Rmd).

## Getting Ready for Code

I had a few tasks to complete before writing any code:

* Update my local installation of [GitHub Desktop](https://desktop.github.com).
* Set up a [GitHub repository](https://github.com/pedstrom/ecmc-proto) for the project.
* Install [RStudio](https://www.rstudio.com), which gave me a run-time error `Unable to locate R binary by scanning standard locations`. I was able to resolve by installing [R 3.4.3](https://cran.r-project.org/bin/macosx/). Woops!

## Next Steps

From here on out, please follow my thought process in [02-proto.Rmd](02-proto.Rmd). The [pdf](02-proto.pdf) and [html](02-proto.nb.html) files will also include the code-execution results.

Thank you for taking the time to review my thought process on this challenge!

Peter Edstrom
peter@edstrom.net
January 2018

