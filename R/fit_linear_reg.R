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
  # Specify linear regression 
  lm_spec <- parsnip::linear_reg() %>%
    parsnip::set_engine("lm") %>%
    parsnip::set_mode("regression")
  
  # Set up the recipe
  wine_lm_recipe <- recipes::recipe(formula, data = data_frame)
  
  # Training the model.
  wine_lm_fit <- workflows::workflow() %>%
    workflows::add_recipe(wine_lm_recipe) %>%
    workflows::add_model(lm_spec) %>%
    parsnip::fit(data = data_frame)
  
  return(wine_lm_fit)
}