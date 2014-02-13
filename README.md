baseball_R
==========

Supplemental solutions to chapter exercises - "Analyzing Baseball Data with R" (Albert &amp; Marchi, 2013)

This repository is for supplemental solutions to the end-of-chapter exercises for "Analyzing Baseball Data with R", by Jim Albert and Max Marchi.

*This project is still in active development. Feel free to contact me with any issues/bugs/suggestions*

Note:  In solution file headers, if "alternate" is TRUE, there will be an alternate solution set with more efficient code and programming methods.

There are a number of tasks at hand, the first being the primary goal.  They are to

1. Provide solutions based on the material covered in each chapter.

2. Suggest more efficient ways to develop the code to complete each task once the user has a good understanding of how to reach a solution based on the material presented in the chapter.  For example, instead of writing
```
with(hof, plot(OBP, SLG))
curve(0.7 - x, add = TRUE)
curve(0.8 - x, add = TRUE)
curve(0.9 - x, add = TRUE)
curve(1.0 - x, add = TRUE)
text(0.27, 0.42, 'OPS = 0.7')
text(0.27, 0.52, 'OPS = 0.8')
text(0.27, 0.62, 'OPS = 0.9')
text(0.27, 0.72, 'OPS = 1.0')
```
we show examples of how to cut down on repetitive code by using `sapply()`, a `for()` loop, and/or by writing a function.

3. Take the question to a higher level.  Ask and answer follow-up questions that will likely demand a small amount of research into baseball, sabermetrics, etc..This may possibly allow us to discover more meaningful/interesting aspects of the data.

4. Make use of as many of the incredible graphics capabilities that R currently has as we can.

The task list will (hopefully) grow and change as the project develops.

This is my first repository on Github, or any other project collaboration website for that matter. I am an aspiring data scientist, a student at UC Davis, and a lifelong baseball fanatic.

Thanks for reading!

Richard

