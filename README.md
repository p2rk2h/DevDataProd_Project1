Developing Data Products Project - Earthquake Event Visualization
=================================================================

This [Shiny App](https://p2rk2h.shinyapps.io/DevDataProd_Project1/)<sup>1</sup> interactively displays the earthquake events of the last 7 days on world map for given date and magnitude range.

The latest dataset is downloaded from [USGS](http://earthquake.usgs.gov/earthquakes/feed/v1.0/) real-time feeds for plotting each event centered on its epicenter with a circle of radius and color proportional to earthquake magnitude.

The world map is from the 'rworldmap' package.

Browse [slidify slides](http://rpubs.com/p2rk2h/66588) for details and sample screen captures in *index.md*.

Johns Hopkins Coursera 2015 March

<br> </br>

**Footnote:**

  <sup>1</sup> Set *[Sys.setlocale( category = 'LC_ALL' , locale = 'C' )](http://stackoverflow.com/questions/20577764/set-locale-to-system-default-utf-8)* if code contains *as.Date( )*.  Even though app instantiation works locally without setting any *locale*, shinyapps.io web instantiation currently results in a cryptic *"ERROR: 'from' must be finite"* (see [forum](https://groups.google.com/forum/#!topic/shinyapps-users/VHKCz5B0QfE)).

