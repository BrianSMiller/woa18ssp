## About

Woa18ssp is a Matlab package for 4D global ocean sound speed profiling based upon the climatological datasets from the World Ocean Atlas 2018 (WOA18; <https://www.ncei.noaa.gov/products/world-ocean-atlas>).

## What's included

Presently, woa18ssp includes instructions for downloading the required files from WOA18 (see 'Getting started' section of this document below) and other dependencies. It includes a routine for converting WOA18 files into sound speeds, and a few subroutines to simplify common requests for data, namely, obtaining data from a single point and time period, and some functions for parsing the file naming schema for woa18 datasets.

Like the WOA18, the woa18ssp contains separate sound speed profiles for 17 different time periods within a year. These time periods are indicated by the same time codes as the woa18. With time codes 01-12 indicating the months of the year from Jan-Dec, time codes 13-16 indicating the quarters of the year (13:Jan-Mar, 14:Apr-Jun, 15:Jul-Sep, 16:Oct-Dec), and time code 00: annual statistics with all data used. In this software I have tried to strike a balance between remaining compatible with woa18 conventions, vs making the software accessible, simple, and straightforward to use.

This package was inspired by previous WOA sound speed profiles offered by Brian Dushaw from the University of Washington (<https://staff.washington.edu/dushaw/WOA/>). However, woa18ssp is not intended as a continuation or drop-in replacement for Dr Dushaw's software, and no code nor data from these previous packages has been included.

## Getting started and typical usage:

1.  Download all woa18ssp files (from Github repository) to a location on your computer, and add this location to the Matlab path.

2.  Woa18ssp is dependent on the function sw_svel (seawater sound velocity) from the (deprecated) 'SeaWater' Matlab software library. This software can be downloaded from <https://researchdata.edu.au/csiro-marine-research-library-2006/692093>. After download and extraction of m-files, make sure that sw_svel.m is added to the Matlab path. TODO: replace with 

3.  Download and install wget (using your package manager on Linux or Mac OS or from <https://gnuwin32.sourceforge.net/packages/wget.htm> if on Windows).

4.  With wget installed, navigate to the download location (e.g. c:\users\my\_name\data) and run the following commands to download the required woa18 data files: 
    ```
    wget -r -nH --cut-dirs=5 --no-parent --reject="index.html*" -nc -w 5 "<https://www.ncei.noaa.gov/data/oceans/woa/WOA18/DATA/temperature/netcdf/A5B7/0.25/>"       wget -r -nH --cut-dirs=5 --no-parent --reject="index.html*" -nc -w 5 "<https://www.ncei.noaa.gov/data/oceans/woa/WOA18/DATA/salinity/netcdf/A5B7/0.25/>"
    
    ```
Upon completion, each folder should contain 17 netcdf (.nc) files (one for each of the above listed time periods). If the server is busy, you may need to run these commands several times to ensure that all files are downloaded.

5.  In Matlab, with the woa18ssp folder added to your Matlab path, run the function makeGlobalSSPsFromWoa18.m, passing in the appropriate arguments for the location of the data files downloaded in step 3, the location of the folder to your sound speed profiles, the decade (above 'A5B7') and grid size (above is '0.25').

    Upon completion this function will have generated 17 global ocean sound speed files (one for each of the 17 time periods) as Matlab binary files (with extension .mat).

6.  Edit the file getWoaSoundSpeedFolder.m so that the path matches the location of the 17 .mat ssp files in step 4.

7.  Use function sspWOA18.m to extract sound speed profile for a given longitude, latitude, and time period(s).

## Please cite as:

### Citation for woa18ssp

Miller, BS (2023) Global ocean sound speed profiles based on the World Ocean Atlas 2018. [Date accessed].

### Citations for WOA18:

Boyer, Tim P.; Garcia, Hernan E.; Locarnini, Ricardo A.; Zweng, Melissa M.; Mishonov, Alexey V.; Reagan, James R.; Weathers, Katharine A.; Baranova, Olga K.; Seidov, Dan; Smolyar, Igor V. (2018). World Ocean Atlas 2018. Objectively Analyzed Salinity and Temperature Data. NOAA National Centers for Environmental Information. Dataset. <https://www.ncei.noaa.gov/archive/accession/NCEI-WOA18>. Accessed [date]

Temperature: Locarnini, R. A., A. V. Mishonov, O. K. Baranova, T. P. Boyer, M. M. Zweng, H. E. Garcia, J. R. Reagan, D. Seidov, K. Weathers, C. R. Paver, and I. Smolyar, 2018. World Ocean Atlas 2018, Volume 1: Temperature.

A. Mishonov Technical Ed.; NOAA Atlas NESDIS 81, 52pp Salinity: Zweng, M. M., J. R. Reagan, D. Seidov, T. P. Boyer, R. A. Locarnini, H. E. Garcia, A. V. Mishonov, O. K. Baranova, K. Weathers, C. R. Paver, and I. Smolyar, 2018. World Ocean Atlas 2018, Volume 2: Salinity. A. Mishonov Technical Ed.; NOAA Atlas NESDIS 82, 50pp.
