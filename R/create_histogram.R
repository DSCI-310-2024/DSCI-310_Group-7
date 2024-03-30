#' create_histogram
#' 
#' Creates ggplot histograms with x labels, different coloured qualities, and
#' specifiable x-axis, y-axis, labels bundled into a workflow. It is then applied 
#' to a workflow where the input is training data, and the workflow is used 
#' alongside cowplot commands to create the visualization.
#'
#' @param data_frame A training data frame or data frame extension (e.g. a tibble).
#' @param x The column within data_frame that should serve as the x axis.
#' @param group The column within data_frame that the histogram should be coloured by.
#' @param x_lab A string if a label for the x-axis is required. Default is element_blank() (no axis label).
#' @param y_lab A string if a label for the y-axis is required. Default is element_blank() (no axis label).
#' @param font_size Size of the font used in the histogram. Default is 10.5.
#'
#' @return A histogram created by ggplot.
#'  The histogram should have different colours based on the quality of wine.
#'  The x-label should always show, while the y-axis is only shown if add_y_lab = TRUE.
#'  Returned histogram should work well with cowplot so the histograms are joined as one
#'  visualization.  
#' @export
#'
#' @examples
#' create_histogram(data_frame = training, x = chlorides, group = quality, 
#'                  x_lab = "Chlorides", font_size = 10.5)
#' 
create_histogram <- function(data_frame, 
                             x, 
                             group, 
                             x_lab = element_blank(), 
                             y_lab = element_blank(), 
                             font_size = 10.5) {
  
  histogram <- data_frame %>%
    ggplot(aes(x = {{x}})) +
    geom_histogram(aes(color = {{y}}, fill = {{y}})) + 
    xlab(x_lab) +
    theme(text = element_text(size=font_size),
          legend.position="none",
          axis.title.y = y_lab)
  
  return(histogram)
}