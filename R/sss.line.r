#' @export sss.line
#' 
#' @title Draws a Simple Systematic Sample (SSS) from a linear resource (i.e., of a
#' line).
#' 
#' @description Draws a systematic from a SpatialLines object (SpatialLines defined in
#' library 'sp').
#' 
#' @details This function is simply a wrapper for \code{spsample} in package 'sp'.
#' 
#' @param n Sample size.  Number of locations to draw from the set of all lines
#' contained in \code{shp}.
#' @param shp A SpatialLiness or SpatialLinessDataFrame object. This object
#' must contain at least 1 line.  If it contains more than 1 line, the sample
#' is drawn from the union of all lines.
#' @return A SpatialPointsDataFrame containing locations in the SSS sample, in
#' arbitrary order.
#' @author Trent McDonald
#' @seealso \code{\link{sss.polygon}}, \code{\link{spsample}}
#' @keywords design survey
#' @examples
#' 
#' 
#' HI.samp <- sss.line( 100, HI.coast )   # square grid oriented east-west
#' plot( HI.coast, col=rainbow(length(HI.coast)) )
#' points( HI.samp, col="red", pch=16 )
#' 
#' 
sss.line <- function(n, shp){

if( regexpr("Lines", class(shp)) < 0 ) stop("Must call sss.line with a SpatialLinesX object.")

#   This is easy, use spsample from the sp package.
#   Note: this is the only function that requires the Depends: sp statement in DESCRIPTION.
#   Without this call to spsample, you can Import sp, rather than Depend it.
samp <- spsample( shp, n, type="regular" )

#   Make answer into a SpatialPointsDataFrame to be consistent with other SDraw routines
#   It would be nice to transfer over the attributes of shp, but shp is a line, 
#   and the over() function does not take points over lines (makes sense, no area to lines). 
#   And, I cannot figure out a nice way to buffer the lines and use over.

samp <- SpatialPointsDataFrame( samp,  data=data.frame(siteID=1:length(samp)) )

samp

}
