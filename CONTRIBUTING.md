# Group 7 Contributing Guideline
This guide describes how to propose a change to the project. 

We welcome any input, ideas, and feedback to our project. Whether it would be a bug fix, a new visualization, or a new model. Please be aware that all contributions that are accepted will be under the [Project's licence](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction/tree/main?tab=MIT-1-ov-file).

## Changes
This project will follow the "GitHub Flow" workflow. Detailed contributing guidelines can be found in the [DSCI 310 textbook](https://ubc-dsci.github.io/reproducible-and-trustworthy-workflows-for-data-science/materials/lectures/02-version-control-2.html).

In short: 
* Create an issue so that other contributors may review it and agree if it is needed.
* Set up the repository following the guidelines established in the [README.md](https://github.com/DSCI-310-2024/dsci-310_group-7_wine-quality-prediction/tree/main?tab=readme-ov-file).
* Create a unique branch through ```git switch -c <your-branch>```.
* Once your contribution has been added, commit and push the changes to your branch through: 
```
git add <modified-file>
git commit -m "Some descriptive message about your change"
git push origin <your-branch>
```
* Please submit a pull request on GitHub so that other contributors may review the changes before merging the branch back to main.

Furthermore, note:
* We use roxygen2, with Markdown syntax, for documentation.
* We use testthat. Contributions with test cases included are easier to accept.
* New code should follow the tidyverse style guide. 

## Code of Conduct
Please note that this project follows a [Code of Conduct](https://github.com/DSCI-310-2024/DSCI-310_Group-7/blob/4d803ebe7bc72506d42578df986d87f705cc38df/CODE_OF_CONDUCT.md). You must abide by these terms to contribute to the project.

## Attribution
This contributing guide is inspired by the dplyr contributing guide, available [here](https://github.com/tidyverse/dplyr/blob/d69802224a1df16d7a795ce313880116ea62ed6e/.github/CONTRIBUTING.md).
