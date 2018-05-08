# websitebuilder

An R package to built website from static html files. These package builts navigation bar as defined in the configuration file using [Bootstrap](https://getbootstrap.com/) libraries. This will help to make as many as website from the same workspace and without recompiling the R markdown files. 

## Installation
```r
install.packages("devtools")
devtools::install_github("vondoRishi/websitebuilder")
```

## Example

Copy the configuration file .yml and html files to work directory "website_test"
```r
dir.create("website_test")
file.copy(from=system.file("extdata",c("R_HTML_document.html" ,"rMarkdown_doc.html","rMarkdown_notebook.nb.html"  ,"site.yml"),package = "websitebuilder"),"website_test")
setwd("website_test")
```

check the contents of the files

```r
> list.files()
# [1] "R_HTML_document.html"       "rMarkdown_doc.html"        
# [3] "rMarkdown_notebook.nb.html" "site.yml" 
> browseURL("rMarkdown_notebook.nb.html")

```

Site configuration file

```r
browseURL("site.yml")

```

### Preparing the site

```r
prepareSite(ymlFile = "site.yml")
browseURL("website_test/R_HTML_document.html")
```

