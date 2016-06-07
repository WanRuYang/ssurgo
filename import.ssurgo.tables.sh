#!/bin/bash

"""
# http://allredbw.com/resources/import.ssurgo.tables.sh
# modified using the script above 
# mostly about incompatible data types

# Bash script to import mapunit, component, coecoclass, and mupolygon (shapefile)
SSURGO tables into PostgreSQL/PostGIS (ver. 1.5). Database (spatially
referenced), schemas, and tables must have been already created (see
ssurgotables.sql).

# Script will loop over individual SSURGO maps downloaded from the USDA
# Geospatial Data Gateway. These are combined into a collection of zipped files,
categorized by state. Data will be imported into 'staging' tables first, and
then inserted into working tables.

Database name, host, user, password, etc. will need to change for separate
database.
"""

#define database variables
DATABASE=dataBaseName
PGHOST=localhost
PGUSER=UserName

# first: loop over state zip files
for statefile in *.zip
# for statefile in soil_az*.zip
do #unzip state file
# unzip -q $statefile -d ${statefile:0:8}
unzip -q $statefile 

# second: loop over map files
# for mapfile in ${statefile:0:8}/*.zip
# do #unzip map file
# unzip -q $mapfile -d ${statefile:0:8}

# echo mapfile for potential error checking
# echo ${mapfile:0:19}
echo ${statefile:0:10}

# #copy comp.txt and cecoclas.txt
#ln ${statefile:0:10}/tabular/chaashto.txt ${statefile:0:10}/tabular/chaashto.txt
ln ${statefile:0:10}/tabular/chconsis.txt ${statefile:0:10}/tabular/chconsistence.txt
ln ${statefile:0:10}/tabular/chdsuffx.txt ${statefile:0:10}/tabular/chdesgnsuffix.txt
#ln ${statefile:0:10}/tabular/chfrags.txt ${statefile:0:10}/tabular/chfrags.txt
#ln ${statefile:0:10}/tabular/chorizon.txt ${statefile:0:10}/tabular/chorizon.txt
#ln ${statefile:0:10}/tabular/chpores.txt ${statefile:0:10}/tabular/chpores.txt
ln ${statefile:0:10}/tabular/chstr.txt ${statefile:0:10}/tabular/chstruct.txt
ln ${statefile:0:10}/tabular/chstrgrp.txt ${statefile:0:10}/tabular/chstructgrp.txt
#ln ${statefile:0:10}/tabular/chtext.txt ${statefile:0:10}/tabular/chtext.txt
ln ${statefile:0:10}/tabular/chtextur.txt ${statefile:0:10}/tabular/chtexture.txt
ln ${statefile:0:10}/tabular/chtexgrp.txt ${statefile:0:10}/tabular/chtexturegrp.txt
ln ${statefile:0:10}/tabular/chtexmod.txt ${statefile:0:10}/tabular/chtexturemod.txt
ln ${statefile:0:10}/tabular/chunifie.txt ${statefile:0:10}/tabular/chunified.txt
ln ${statefile:0:10}/tabular/ccancov.txt ${statefile:0:10}/tabular/cocanopycover.txt
ln ${statefile:0:10}/tabular/ccrpyd.txt ${statefile:0:10}/tabular/cocropyld.txt
ln ${statefile:0:10}/tabular/cdfeat.txt ${statefile:0:10}/tabular/codiagfeatures.txt
ln ${statefile:0:10}/tabular/cecoclas.txt ${statefile:0:10}/tabular/coecoclass.txt
ln ${statefile:0:10}/tabular/ceplants.txt ${statefile:0:10}/tabular/coeplants.txt
ln ${statefile:0:10}/tabular/cerosnac.txt ${statefile:0:10}/tabular/coerosionacc.txt
ln ${statefile:0:10}/tabular/cfprod.txt ${statefile:0:10}/tabular/coforprod.txt
ln ${statefile:0:10}/tabular/cfprodo.txt ${statefile:0:10}/tabular/coforprodo.txt
ln ${statefile:0:10}/tabular/cgeomord.txt ${statefile:0:10}/tabular/cogeomordesc.txt
ln ${statefile:0:10}/tabular/chydcrit.txt ${statefile:0:10}/tabular/cohydriccriteria.txt
ln ${statefile:0:10}/tabular/cinterp.txt ${statefile:0:10}/tabular/cointerp.txt
ln ${statefile:0:10}/tabular/cmonth.txt ${statefile:0:10}/tabular/comonth.txt
ln ${statefile:0:10}/tabular/comp.txt ${statefile:0:10}/tabular/component.txt
ln ${statefile:0:10}/tabular/cpmat.txt ${statefile:0:10}/tabular/copm.txt
ln ${statefile:0:10}/tabular/cpmatgrp.txt ${statefile:0:10}/tabular/copmgrp.txt
ln ${statefile:0:10}/tabular/cpwndbrk.txt ${statefile:0:10}/tabular/copwindbreak.txt
ln ${statefile:0:10}/tabular/crstrcts.txt ${statefile:0:10}/tabular/corestrictions.txt
ln ${statefile:0:10}/tabular/csmoist.txt ${statefile:0:10}/tabular/cosoilmoist.txt
ln ${statefile:0:10}/tabular/cstemp.txt ${statefile:0:10}/tabular/cosoiltemp.txt
ln ${statefile:0:10}/tabular/csfrags.txt ${statefile:0:10}/tabular/cosurffrags.txt
ln ${statefile:0:10}/tabular/csmorgc.txt ${statefile:0:10}/tabular/cosurfmorphgc.txt
ln ${statefile:0:10}/tabular/csmorhpp.txt ${statefile:0:10}/tabular/cosurfmorphhpp.txt
ln ${statefile:0:10}/tabular/csmormr.txt ${statefile:0:10}/tabular/cosurfmorphmr.txt
ln ${statefile:0:10}/tabular/csmorss.txt ${statefile:0:10}/tabular/cosurfmorphss.txt
ln ${statefile:0:10}/tabular/ctxfmmin.txt ${statefile:0:10}/tabular/cotaxfmmin.txt
ln ${statefile:0:10}/tabular/ctxmoicl.txt ${statefile:0:10}/tabular/cotaxmoistcl.txt
ln ${statefile:0:10}/tabular/ctext.txt ${statefile:0:10}/tabular/cotext.txt
ln ${statefile:0:10}/tabular/ctreestm.txt ${statefile:0:10}/tabular/cotreestomng.txt
ln ${statefile:0:10}/tabular/ctxfmoth.txt ${statefile:0:10}/tabular/cotxfmother.txt
ln ${statefile:0:10}/tabular/distimd.txt ${statefile:0:10}/tabular/distinterpmd.txt
ln ${statefile:0:10}/tabular/distlmd.txt ${statefile:0:10}/tabular/distlegendmd.txt
#ln ${statefile:0:10}/tabular/distmd.txt ${statefile:0:10}/tabular/distmd.txt
ln ${statefile:0:10}/tabular/lareao.txt ${statefile:0:10}/tabular/laoverlap.txt
#ln ${statefile:0:10}/tabular/legend.txt ${statefile:0:10}/tabular/legend.txt
ln ${statefile:0:10}/tabular/ltext.txt ${statefile:0:10}/tabular/legendtext.txt
#ln ${statefile:0:10}/tabular/mapunit.txt ${statefile:0:10}/tabular/mapunit.txt
ln ${statefile:0:10}/tabular/msdomdet.txt ${statefile:0:10}/tabular/mdstatdomdet.txt
ln ${statefile:0:10}/tabular/msdommas.txt ${statefile:0:10}/tabular/mdstatdommas.txt
ln ${statefile:0:10}/tabular/msidxdet.txt ${statefile:0:10}/tabular/mdstatidxdet.txt
ln ${statefile:0:10}/tabular/msidxmas.txt ${statefile:0:10}/tabular/mdstatidxmas.txt
ln ${statefile:0:10}/tabular/msrsdet.txt ${statefile:0:10}/tabular/mdstatrshipdet.txt
ln ${statefile:0:10}/tabular/msrsmas.txt ${statefile:0:10}/tabular/mdstatrshipmas.txt
ln ${statefile:0:10}/tabular/mstabcol.txt ${statefile:0:10}/tabular/mdstattabcols.txt
ln ${statefile:0:10}/tabular/mstab.txt ${statefile:0:10}/tabular/mdstattabs.txt
#ln ${statefile:0:10}/tabular/muaggatt.txt ${statefile:0:10}/tabular/muaggatt.txt
ln ${statefile:0:10}/tabular/muareao.txt ${statefile:0:10}/tabular/muaoverlap.txt
ln ${statefile:0:10}/tabular/mucrpyd.txt ${statefile:0:10}/tabular/mucropyld.txt
#ln ${statefile:0:10}/tabular/mutext.txt ${statefile:0:10}/tabular/mutext.txt
ln ${statefile:0:10}/tabular/sacatlog.txt ${statefile:0:10}/tabular/sacatalog.txt
#ln ${statefile:0:10}/tabular/sainterp.txt ${statefile:0:10}/tabular/sainterp.txt
#ln ${statefile:0:10}/tabular/sdvalgorithm.txt ${statefile:0:10}/tabular/sdvalgorithm.txt
#ln ${statefile:0:10}/tabular/sdvattribute.txt ${statefile:0:10}/tabular/sdvattribute.txt
#ln ${statefile:0:10}/tabular/sdvfolder.txt ${statefile:0:10}/tabular/sdvfolder.txt
#ln ${statefile:0:10}/tabular/sdvfolderattribute.txt ${statefile:0:10}/tabular/sdvfolderattribute.txt

#third loop over staging tables
#for table in stagemapunit stagecomponent stagecoecoclass
for table in stagechaashto stagechconsistence stagechdesgnsuffix stagechfrags stagechorizon stagechpores stagechstruct stagechstructgrp stagechtext stagechtexture stagechtexturegrp stagechtexturemod stagechunified stagecocanopycover stagecocropyld stagecodiagfeatures stagecoecoclass stagecoeplants stagecoerosionacc stagecoforprod stagecoforprodo stagecogeomordesc stagecohydriccriteria stagecointerp stagecomonth stagecomponent stagecopm stagecopmgrp stagecopwindbreak stagecorestrictions stagecosoilmoist stagecosoiltemp stagecosurffrags stagecosurfmorphgc stagecosurfmorphhpp stagecosurfmorphmr stagecosurfmorphss stagecotaxfmmin stagecotaxmoistcl stagecotext stagecotreestomng stagecotxfmother stagedistinterpmd stagedistlegendmd stagedistmd stagelaoverlap stagelegend stagelegendtext stagemapunit stagemdstatdomdet stagemdstatdommas stagemdstatidxdet stagemdstatidxmas stagemdstatrshipdet stagemdstatrshipmas stagemdstattabcols stagemdstattabs stagemuaggatt stagemuaoverlap stagemucropyld stagemutext stagesacatalog stagesainterp stagesdvalgorithm stagesdvattribute stagesdvfolder stagesdvfolderattribute
do

#create staging table, empty copy of table
psql -q -d $DATABASE -c "create table $table as select * from
ssurgo.${table:5} where 1=2;"

#import into staging table
# psql -q -d $DATABASE -c "\copy $table from
# ${mapfile:0:19}/tabular/${table:5}.txt with csv delimiter as '|' null as ''"
psql -q -d $DATABASE << EOF
set datestyle="SQL, MDY";
\copy $table from ${statefile:0:10}/tabular/${table:5}.txt with csv delimiter as '|' null as '';
EOF

#insert data into working table
psql -q -d $DATABASE -c "insert into ssurgo.${table:5} select * from $table;"

#drop staging table
psql -q -d $DATABASE -c "drop table $table;"

#close third loop
done

#import shapefile into stagemupolygon
shp2pgsql -c -s 4269 ${statefile:0:10}/spatial/soilmu_a_${statefile:5:5} \
ssurgo.stagemupolygon | psql -q -d $DATABASE &>/dev/null

#insert stagemupolygon into mupolygon
psql -q -d $DATABASE -c 'insert into ssurgo.mupolygon select * from
ssurgo.stagemupolygon;'

#drop stagemupolyong, using PostGIS
psql -q -d $DATABASE -c "select dropgeometrytable('ssurgo','stagemupolygon');"\
&>/dev/null

# #delete map directory
# rm -rf ${mapfile:0:19}

# #close second loop
# done

#delete state directory
# rm -rf ${statefile:0:8}
rm -rf ${statefile:0:10}

#close first loop
done

