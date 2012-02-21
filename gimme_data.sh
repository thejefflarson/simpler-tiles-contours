#!/bin/bash

mkdir data

WD=`pwd`
usgs_em () {
  directory=$WD/$1
  get_em $directory "http://edcftp.cr.usgs.gov/pub/data/gtopo30/global/"
  unzip_em $directory
  contour_em $directory
}

get_em () {
  echo "Getting" $1 $2
  wget -A tar.gz -m -np -nH -c -nd -P  $1 $2
}

unzip_em () {
  cd $1
  ls *.tar.gz | xargs -I{} tar -xzvf {}
  cd $WD
}

contour_em () {
  cd $1
  rm *.shp
  rm *.shx
  rm *.dbf
  for file in W140N90.DEM W100N90.DEM W060N90.DEM W140N40.DEM W100N40.DEM W060N40.DEM
  do
    echo "Processing $file"
    gdal_contour $file `basename $file .DEM`.shp -i 100
  done
  cd $WD
}

usgs_em 'data'
