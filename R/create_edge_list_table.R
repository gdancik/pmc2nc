#' Create edge list table if not found.
#'
#' `create_edge_list_table` create edge list table in MySQL.

#' @details
#' Default values for this table is: 
#' tableName = "EdgeList", sourceName = "Source", targetName = "Target"
#' MySQL statment:
#' CREATE TABLE Edgelist_date (
#' SourcePMID INT,
#' Target INT,
#' INDEX index_target(Target));
#' 
#' @param con_mysql a MySQL connection 
#' @param tableName string with the name of the table used to store the edge list, defaulting to 'EdgeList'
#' @param sourceName string with the name of the column used to store the source, defaulting to 'Source'
#' @param targetName string with the name of the column used to store the target, defaulting to 'Target' 
#' @return a scalar numeric that specifies the number of rows
#'         affected by the statement. An error is raised when issuing a statement over a closed
#'         or invalid connection, if the syntax of the statement is invalid, or if the statement is
#'         not a non-NA string.
#'
#' @examples
#'

#' @export
create_edge_list_table <- function(con_mysql, tableName = "EdgeList", sourceName = "Source", targetName = "Target"){

   if (!requireNamespace("RMariaDB", quietly = TRUE)) {
    stop("Package \"RMariaDB\" needed for this function to work. Please install it.",
      call. = FALSE)
  }
    # This will search if tableName exist in database
  qry <- paste0("show tables like '",tableName,"';")
  res <- RMariaDB::dbGetQuery(con_mysql, qry)
  
  # Create the table if it is not found by checking length of res
  if (length(res[[1]]) == 0){
    print("create_edge_list_table: No table found. Creating table now.")
    qry <- paste0("CREATE TABLE ",tableName," (
                  ",sourceName," INT,
                  ",targetName," INT,
                  INDEX index_target(",targetName,"));")
    RMariaDB::dbExecute(con_mysql, qry)
  }else{
    print("create_edge_list_table: Table is found.")
  }
}
