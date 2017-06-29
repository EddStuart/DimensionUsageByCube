# Set Maximum number of Dimensions in ANY cube
vMaxDims=30;
#Set name of Audit cube
vAuditCube='zCubeDimsTI';
#Set cube clear view
vClearView = 'ClearView';

# Create vAuditCube if required (does not exist)
IF (CubeExists(vAuditCube)<>1);
 CubeCreate(vAuditCube,'}Dimensions','}Cubes','zCubeDimMeasures');
ENDIF;
# Create Clear Cube view if necessary
IF (ViewExists (vAuditCube,vClearView) <> 1);
 ViewCreate(vAuditCube,vClearView);
 ViewRowDimensionSet(vAuditCube, vClearView, '}Cubes', 1);
 ViewRowDimensionSet(vAuditCube, vClearView, '}Dimensions', 2);
 ViewRowDimensionSet(vAuditCube, vClearView, 'zCubeDimMeasures',
3);
 ViewSuppressZeroesSet(vAuditCube, vClearView, 1);
ENDIF;
#Clear cube
ViewZeroOut (vAuditCube, vClearView);
# Set looping variables
vNumCubes = DIMSIZ('}Cubes');
vCubeLoop=0;
#Loop through cubes
WHILE (vCubeLoop < vNumCubes);
vCubeLoop = vCubeLoop + 1;

vCubeName=DIMNM ('}Cubes',vCubeLoop);

vEnumLoop = 0;
# Loop through Dimensions
 WHILE (vEnumLoop < vMaxDims);
 vEnumLoop = vEnumLoop+1;
 vDimName = TABDIM(vCubeName,vEnumLoop);
 IF (vDimName @<> '');
 CellPutN(vEnumLoop,vAuditCube,vDimName,vCubeName,'Position');
 CellPutS('X',vAuditCube,vDimName,vCubeName,'Exists'); 
 ENDIF;
 END;
END; 
