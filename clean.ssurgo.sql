--SQL script to clean up imported SSURGO data, create constraints and indicies.*/

--increase work_mem to 6GB; value dependent upon database system
SET work_mem = '6GB';
--increase maintenance_work_mem to 4GB; allows for faster indexing, value 
--dependent upon machine

SET maintenance_work_mem = '4GB';

--remove duplicates from imported tables by creating new table with distinct
CREATE TABLE ssurgo.tmpmapunit AS SELECT DISTINCT * FROM mapunit;
DROP TABLE mapunit;
ALTER TABLE tmpmapunit rename to mapunit;
ALTER TABLE mapunit alter column mukey SET not null;

CREATE TABLE ssurgo.tmpcomponent AS SELECT  DISTINCT * FROM component;
DROP TABLE component;
ALTER TABLE tmpcomponent rename to component;
ALTER TABLE component alter column cokey set not null;

CREATE TABLE ssurgo.tmpcoecoclass AS SELECT  DISTINCT * FROM coecoclass;
DROP TABLE coecoclass;
ALTER TABLE tmpcoecoclass rename to coecoclass;

CREATE TABLE ssurgo.tmpmupolygon AS SELECT  DISTINCT * FROM mupolygon;
DROP TABLE mupolygon;
ALTER TABLE tmpmupolygon rename to mupolygon;

--add constraints and indices
--mapunit table
ALTER TABLE mapunit add primary key (mukey);

--component table
ALTER TABLE component add primary key (cokey);
CREATE INDEX component_mukey_idx on component using btree (mukey);
ALTER TABLE component add constraint component_mapunit_fkey foreign key (mukey)
references mapunit(mukey) on delete cascade;

--coecoclass table
ALTER TABLE coecoclass add primary key (coecoclasskey);
create index coecoclass_cokey_idx on coecoclass using btree (cokey);
create index coecoclass_ecoclassid_idx ON coecoclass using btree (ecoclassid);
ALTER TABLE coecoclass add constraint coecoclass_component_fkey foreign key
(cokey) references component(cokey) on delete cascade;

--mupolygon table
--create index on geometry column
create index mupolygon_the_geom_idx ON ssurgo.mupolygon using gist(the_geom);
--drop gid column and recreate as serial and primary key
ALTER TABLE mupolygon DROP COLUMN gid;
ALTER TABLE mupolygon ADD COLUMN gid serial;
ALTER TABLE mupolygon ADD primary key(gid);
--populate geometry columns
SELECT populate_geometry_columns('ssurgo.mupolygon'::regclass);
