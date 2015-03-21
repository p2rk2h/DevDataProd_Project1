library( shiny )	# ui.R
	dt7 <- rev( seq( as.Date( date( ) , '%A %B %d %H:%M:%S %Y' ) , length = 7 , by = - 1 ) )	# date range
	mg7 <- seq( 0 , 8 )	# mag range
	drng <- paste( c( as.character( dt7[ 1 ] ) , ' - ' , as.character( dt7[ 7 ] ) ) , sep = '' )

shinyUI( fluidPage(	# Application title
	headerPanel(
		h2( 'Earthquake Events of the Last 7 Days (Coursera 2015 March)' ) ,
			tags$head( tags$img( src = 'header_graphic_usgsIdentifier_white.jpg' , align = 'left' ) )
	) ,

	sidebarLayout(	# Sidebar with a slider input for the number of bins
		sidebarPanel(
			h6( 'Loading the latest data from USGS web site ...' ) ,
			dateRangeInput( 'd12' ,
				h4( 'Select date range:' ) ,
				start = dt7[ 5 ] , end = dt7[ 7 ] ,
				min = dt7[ 1 ] , max = dt7[ 7 ] ) ,
			sliderInput( 'm12' ,
				h4( 'Select magnitude range:' ) ,
				min = mg7[ 1 ] , max = mg7[ 9 ] , value = c( 2 , 5 ) ) ,
			width = 4
		) ,

		mainPanel(	# Show a plot of the generated distribution
			tabsetPanel( type = 'tabs' ,
				tabPanel( 'About' ,
					includeMarkdown( 'about.md' ) ,
					tags$br( ) ,
					h3( 'Objective:' ) ,
					'See on world map where earthquake events' ,
					'of the last 7 days are from USGS real-time Feeds.' ,
					tags$br( ) ,
					tags$b( 'User Interaction:' ) ,
					'Select events by date and magnitude range.' ,
					tags$br( ) ,
					h3( 'Date Range:' ) ,
					as.character( drng ) ,
					tags$br( ) ,
					h3( 'Data Source:' ) ,
					'USGS Earthquake Hazards Program: Real-time Feeds: http://earthquake.usgs.gov/earthquakes/feed/v1.0/' ,
					tags$br( ) ,
					tags$br( ) ,
					h4( 'Packages:' ) ,
					'\'ggplot\' , \'rworldmap\' , \'shiny\'' ,
					tags$br( ) ,
					tags$br( ) ,
					h4( 'GitHub:' ) ,
					'http://github.com/p2rk2h/DevDataProd_Project' ,
					tags$br( ) ,
					'Developing Data Products (Johns Hopkins Coursera 2015 March)'
				) ,

				tabPanel( 'Events' ,
					plotOutput( 'rthqPlt' )
					) ,

				tabPanel( 'Data' ,
					h4( textOutput( 'rng' ) ) ,
					tags$br( ) ,
					h3( 'Event Summary:' ) ,
					tableOutput( 'smry' ) ,
					tags$br( ) ,
					h3( 'Earthquake Events:' ) ,
					tableOutput( 'rthq' )
				)
			)
		) )
) )
