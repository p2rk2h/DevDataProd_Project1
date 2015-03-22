library( shiny )	# server.R
library( rworldmap )
library( mapproj )
library( ggplot2 )

Sys.setlocale( category = 'LC_ALL' , locale = 'C' )	# for shinyapps.io
rthC <- rev( heat.colors( 8 ) )	# color scale for mag 0 - 7+

readUsgsCsv <- function( x ) {	# load last 7-day data from all_week.csv
	x <- paste( 'all_' , x , '.csv' , sep = '' )
	url <- paste( 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/' , x , sep = '' )
	tryCatch( {
		download.file( url , x , mode = 'wb' )
		df <- read.csv( paste( './' , x , sep = '' ) , stringsAsFactors = FALSE , header = T )	# read CSV file
		} , error = function( e ) {
###			message( '***** ERROR downloading from (' , url , ') *****' )
###			message( '***** Using default demo data file\t*****' )
		df <- read.csv( './all_week2.csv' , stringsAsFactors = FALSE , header = T )	# read default CSV file

		} , finally = {

	df$date <- as.Date( substr( df$time , 1 , 10 ) )	# data preparation
	df$col <- rthC[ as.numeric( lapply( df$mag , function( x ) {
		round( max( 0 , min( 7 , x ) ) ) + 1 } ) ) ]	# map magnitude to color
	df$longitude <- round( df$longitude , 2 )
	df$latitude <- round( df$latitude , 2 )
		}
	)

	return( df[ , names( df ) %in% c( 'date' , 'mag' , 'col' , 'time' , 'longitude' , 'latitude' , 'depth' , 'place' , 'net' ) ] )	# return subset
}

	dfSub <- readUsgsCsv( 'week' )	# get current week
	dtdf <- as.Date( date( ) , '%A %B %d %H:%M:%S %Y' ) - dfSub$date[ 1 ]

	data( 'countryExData' , envir = environment( ) , package = 'rworldmap' )
	grmp <- ggplot( ) +
		coord_map( xlim = c( - 180 , 180 ) , ylim = c( - 73 , 80 ) ) +
		geom_polygon( data = fortify( joinCountryData2Map( countryExData , joinCode = 'ISO3' , nameJoinColumn = 'ISO3V10' , mapResolution = 'coarse' ) ) , aes( long , lat , group = group ) , color = 'black' , fill = 'green' , size = 0.3 )	# get world map

shinyServer( function( input , output ) {
	dtdf2 <- reactive( { input$d12 - dtdf } )
	dfSub2 <- reactive( { subset( dfSub ,
		! ( date > dtdf2( )[ 2 ] | date < dtdf2( )[ 1 ] )
		& ! ( mag > input$m12[ 2 ] | mag < input$m12[ 1 ] ) ) } )

	rng2 <- reactive( { paste( c( 'Earthquakes of (' , as.character( dtdf2( )[ 1 ] ) , ', ' , as.character( dtdf2( )[ 2 ] ) ,
		') and magnitudes (' , round( input$m12[ 1 ] , 1 ) , ', ' , round( input$m12[ 2 ] , 1 ) , ')' ) , sep = '' ) } )

	rvlsm2 <- reactive( { summary( dfSub2( ) ) } )
	smryT <- reactive( { data.frame( Lat = rvlsm2( )[ , 2 ] ,
		Long = rvlsm2( )[ , 3 ] ,
		Depth = rvlsm2( )[ , 4 ] ,
		Mag = rvlsm2( )[ , 5 ] ) } )
	dfSub2a <- reactive( { subset( dfSub2( ) ,
		names( dfSub2( ) ) %in% c( 'time' , 'latitude' , 'longitude' , 'depth' , 'mag' , 'place' ) ) } )

	output$rthqPlt <- renderPlot( {
		grmp + geom_point( data = dfSub2( ) , aes( x = longitude , y = latitude ) , color = dfSub2( )$col , cex = dfSub2( )$mag ) +
			labs( title = 'Earthquake events by dates and magnitudes' ) +
			xlim( -181 , 181 ) + ylim( - 74 , 80 )
	} )

	output$rng <- renderText( { rng2( ) } )
	output$smry <- renderTable( { smryT( ) } , include.rownames = FALSE )
	output$rthq <- renderTable( { dfSub2a( ) } , include.rownames = FALSE )
} )
