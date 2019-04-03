## Overview

The _R_ package _pmc2nc_ is a **P**ub**M**ed **C**entral **c**itation **n**etwork **c**onstruction tool for facilitating citation network analyses for articles in PMC.  _pmc2nc_

[Eastern Colleges Science Conference Abstract](http://www.ecsc1.org/2019.html)


**DEVELOPMENT OF A PUBMED CENTRAL CITATION COLLECTION TOOL AND NETWORK ANALYSIS OF CANCER-RELATED GENES**

Identifying relevant research articles is an inefficient task for researchers due to a steadily increasing
number of published articles available across journal databases. Citation analysis tools have previously
been utilized to quantify the relative importance of published journals through the application of network
science measures to citation networks. This study involved the development of a citation collection tool
and subsequent analysis of citation networks for articles available within PubMed Central that mention
cancer genes, such as BRCA2. The citation collection tool, called pmc2nc, allows users to quickly
generate edge lists for articles of interest. The edge list can then be imported into network visualization
and analysis tools. The pmc2nc tool, developed in the R programming language, uses the rentrez package
to extract citation information, and is available as an R package and as a Shiny application. The Gephi
graphing software was used to construct and analyze the networks. Specifically, we used the PageRank
and HITS algorithms to identify "important" articles based on the authority, hub, and PageRank weights.
The interpretation and utility of these measures for identifying important articles will be discussed.


## Availability ##

### Download the R package
```R
# Install the R package from Github using the _devtools_ package:
devtools::install_github('gdancik/pmc2nc')

# generate an edge list for multiple articles
res <- get_pmc_cited_in(c(21876761,29463753))
e <- generateEdgeList(res2)

# get article information (title, authors, etc)
info <- get_article_info(c(21876726,21876761))
```

### Run the Shiny app
A shiny web application, the _shiny citation collection tool (shinycct)_ is available and can be downloaded from [https://github.com/anaxisa/anaxisa.github.io](https://github.com/anaxisa/anaxisa.github.io).

### Run the Shiny app from a docker container (recommended for non-programmers).
1. Download docker from [https://www.docker.com/get-started](https://www.docker.com/get-started)
2. Run the application by typing the following at your docker command prompt:
```
docker run -it -p 3838:3838 gdancik/shinyctt
```
3. Point your browser to localhost:3838
