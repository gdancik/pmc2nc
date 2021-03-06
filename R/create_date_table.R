#' Create edge list date table if not found.
#'
#' `create_date_table` create edge list date table in MySQL

#' @details
#' Default values for this table are: 
#' tableName = "EdgeList_date", targetName = "Target", dateName = "DatePMID"
#' MySQL statment:
#' CREATE TABLE Edgelist_date (
#' Target INT,
#' DatePMID date,
#' INDEX index_target(Target));
#' 
#' @param conMysql an RMariaDB connection
#' @param tableName string with the name of the table used to store the last update dates for pmids
#' @param targetName string with the name of the column used to store the Target PMID of the edge list
#' @param dateName string with the name of the column used to store the date of the update
#' @return create_date_table() always returns a scalar numeric that specifies the number of rows
#'         affected by the statement. An error is raised when issuing a statement over a closed
#'         or invalid connection, if the syntax of the statement is invalid
#' @export
create_date_table <- function(conMysql, tableName = "EdgeList_date", targetName = "Target", dateName = "DatePMID"){
  if (!requireNamespace("RMariaDB", quietly = TRUE)) {
    stop("Package \"RMariaDB\" needed for this function to work. Please install it.",
      call. = FALSE)
  }
  # This will search if tableName exist in database
  qry <- paste0("show tables like '",tableName,"';")
  res <- RMariaDB::dbGetQuery(conMysql, qry)
  
  # Create the table if it is not found by checking length of res
  if (length(res[[1]]) == 0){
    print("create_date_table: No table found. Creating date table now.")
    qry <- paste0("CREATE TABLE ",tableName," (
                  ",targetName," INT,
                  ",dateName," date,
                  INDEX index_target(",targetName,"));")
    RMariaDB::dbExecute(conMysql, qry)
  }else{
    print("create_date_table: Date table already exists.")
  }
}
