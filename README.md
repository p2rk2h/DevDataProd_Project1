Developing Data Products Project - Earthquake Event Visualization
=================================================================

This Shiny App<sup>1</sup> interactively displays the earthquake events of the last 7 days on world map for given date and magnitude range.

The latest dataset is downloaded from [USGS](http://earthquake.usgs.gov/earthquakes/feed/v1.0/) real-time feeds for plotting each event centered on its epicenter with a circle of radius and color proportional to earthquake magnitude.

The world map is from the 'rworldmap' package.

Browse [slidify slides](http://rpubs.com/p2rk2h/66588) for details and sample screen captures in *index.md*.

Johns Hopkins Coursera 2015 March

<br> </br>

**Footnote:**

  <sup>1</sup> **WARNING:** A peculiar web *"ERROR: 'from' must be finite"* results when instantiating the published [shinyapps.io](https://p2rk2h.shinyapps.io/DevDataProd_Project1/).  This despite the Shiny App's

* running correctly from the R Studios in both the MAC OS X and the Windows,
* having successfully published to the shinyapps.io web site, and
* shinyapps.io account in the *Running* status.

I've searched internet to resolve this puzzling error in vain.  Would appreciate learning the root cause and its proper resolution of this web-instantiation error from Coursera faculty, staff, or reviewers.

To run this app locally on R Studio, download relevant files from [GitHub](https://github.com/p2rk2h/DevDataProd_Project1/)
