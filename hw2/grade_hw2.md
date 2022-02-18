*Yuyuan Lin*

### Overall Grade: 174/180

### Quality of report: 10/10

-   Is the homework submitted (git tag time) before deadline? 

    Yes
  
-   Is the final report in a human readable format html? 

    Yes
  
-   Is the report prepared as a dynamic document (R markdown) for better reproducibility?

    Yes
  
-   Is the report clear (whole sentences, typos, grammar)? Do readers have a clear idea what's going on and how are results produced by just reading the report? 

    Yes
  
### Completeness, correctness and efficiency of solution: 115/120

- Q1 (10/10)

`read.csv` should be at least 5-10x slower than `read_csv`. `read_csv` should be about 2-3x slower than `fread`.

Need to comment on the difference in the parsed data types.

- Q2 (10/10)

- Q3 (20/20)

- Q4 (10/10)

- Q5 (20/20)

- Q6 (20/20)

- Q7 (14/20)

    Close! Just forgot to subset for age 18 at time of admission. Otherwise, excellent project. Also, your pipes in this particular problem can be more concise. No reason to have multiple intermediate saves in this situation. `-6. 
    
- Q8 (10/10)

	    
### Usage of Git: 10/10

-   Are branches (`master` and `develop`) correctly set up? Is the hw submission put into the `master` branch?

    Yes
  
-   Are there enough commits? Are commit messages clear? 
 
    Yes
           
-   Is the hw2 submission tagged? 

    Yes
  
-   Are the folders (`hw1`, `hw2`, ...) created correctly? 
  
    Yes
  
-   Do not put a lot auxiliary files into version control. If any unnecessary files are in Git, take 5 points off.

### Reproducibility: 10/10

This HW might be difficult to check reproducibility. 

-   Are the materials (files and instructions) submitted to the `master` branch sufficient for reproducing all the results? Just click the `knit` button will produce the final `html` on teaching server? 

    Yes
  
-   If necessary, are there clear instructions, either in report or in a separate file, how to reproduce the results?

### R code style: 20/20

Each violation takes 2 points off, until all 20 points are depleted.

-   [Rule 2.5](https://style.tidyverse.org/syntax.html#long-lines) The maximum line length is 80 characters.  

-   [Rule 2.4.1](https://style.tidyverse.org/syntax.html#indenting) When indenting your code, use two spaces.  

-   [Rule 2.2.4](https://style.tidyverse.org/syntax.html#infix-operators) Place spaces around all infix operators (=, +, -, &lt;-, etc.).  

-   [Rule 2.2.1.](https://style.tidyverse.org/syntax.html#commas) Do not place a space before a comma, but always place one after a comma.  

-   [Rule 2.2.2](https://style.tidyverse.org/syntax.html#parentheses) Do not place spaces around code in parentheses or square brackets. Place a space before left parenthesis, except in a function call.
