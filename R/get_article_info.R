#' Get article information
#'
#' `get_article_info` takes a vector of article PMIDs and returns summary 
#' information about the articles
#' 
#' @details
#' Returns summary information for a list of articlees
#' This function is a wrapper for the `entrez_summary` and 
#' 'extract_from_esummary' functions from `rentrez`. 
#' Function is currently limited to handling no more than 5000 PMIDs. 
#' The "web history" feature is used to store IDs on the 
#' server, and summary information is retrieved 500 IDs at a time.
#' Currently the 'uid', 'title', 'lastauthor', and 'fulljournalname'
#' for each PMID is obtained.
#' 
#' @param pmids a vector of PMIDs look-up 
#' @return a data.frame containing article information for each PMID
#'
#' @examples
#' res <- get_article_info(c(21876726,21876761))

#' @export
get_article_info <-function(pmids) {
  
  elements <- c("uid", "title", "lastauthor", "fulljournalname")
  pmids <- unique(pmids)
  if (length(pmids) > 5000) {
    stop("can only process up to 5000 unique pmids for now")
  }
  
  wait <- 0.34 # no more than 3 requests per second
  if (Sys.getenv("ENTREZ_KEY") != "") {
    wait <- 0.11 # no more than 10 requests per second
  }
  
  res <- NULL
  upload <- entrez_post(db="pubmed", id=pmids)

  retmax <- 500 # get 500 at a time
  pb <- progress_bar$new(total = ceiling(length(pmids) / retmax))
  
  for (start in seq(0, length(pmids),by = retmax)) {
    e <- entrez_summary(db = "pubmed", web_history = upload, retstart = start, retmax = retmax, always_return_list = TRUE)
    pb$tick()
    r <- extract_from_esummary(e, elements, FALSE)
    res <- rbind(res, do.call(rbind.data.frame, r))
    Sys.sleep(wait)
  }

  return(res)
} 
  
