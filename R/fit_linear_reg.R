#' Fit Linear Regression Model
#' 
#' Specifies a linear regression model, creates a recipe, and bundles them into
#' a workflow. Applies workflow to training data to return a fitted model. 
#'
#' @param formula An R regression formula.
#' @param data_frame A training data frame or data frame extension (e.g. a tibble).
#'
#' @return A fitted linear regression model object. 
#'  Returned object contains finalized recipe and fitted model objects (e.g., 
#'  coefficients) inside.
#' @export
#'
#' @examples
#' fit_linear_reg(quality ~ ., training)
fit_linear_reg <- function(formula, data_frame) {
  # returns a fitted linear regression model (RDS)
}