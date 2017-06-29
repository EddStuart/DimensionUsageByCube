##### CREATE ProcessLogs cube and dimensions #####
## See source details for Dimension usage by cube on developerworks website
## https://www.ibm.com/developerworks/data/library/cognos/page327.html

###############################################
# Declare Variables
###############################################
sCubeDim = 'zCubeDim' ;
sCubeDimMeas = 'zCubeDimMeasures' ;
sCube = 'zCubeDims' ;

###############################################
# Create Dimensions and add Elements
###############################################
DIMENSIONCREATE ( sCubeDim ) ;
DIMENSIONCREATE ( sCubeDimMeas ) ;

DIMENSIONELEMENTINSERT ( sCubeDim, '', 'All CubeDims', 'C' ) ;

## Create loop to generate 10 elements
iMax = 10;
i = 1 ;

WHILE ( i <= iMax ) ;
  iString = NUMBERTOSTRING ( i ) ;
  DIMENSIONELEMENTINSERT ( sCubeDim, '', iString, 'N' ) ;
  DIMENSIONELEMENTCOMPONENTADD ( sCubeDim, 'All CubeDims', iString, 1 ) ;
  i = i + 1 ;
END ;

DIMENSIONELEMENTINSERT ( sCubDimMeas, '', 'Exists', 'S' ) ;
DIMENSIONELEMENTINSERT ( sCubDimMeas, '', 'Position', 'N' ) ;

##############################################
# Create ProcessLogs cube
##############################################

CUBECREATE ( sCube, '}Dimensions', '}Cubes',sCubeDim, sCubeDimMeas ) ;
