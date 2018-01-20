STEP 8: STARTS

-----------------------------Creating External Table From HBase to Hive----------------------
CREATE EXTERNAL TABLE pokemongo_hive(key string, lat FLOAT, lng FLOAT, name string, nodeType string)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = "cf:lat,cf:lng,cf:name,cf:nodeType")
TBLPROPERTIES("hbase.table.name" = "pokemongo");

------------------------------------------------------------------
Confirming that we are able to retrieve all the data
------------------------------------------------------------------
select * from pokemongo_hive;

STEP 8: ENDS

STEP 9: STARTS

------------------------------------------------------------------
All Gyms or Pokestops Within 5 Miles from Main Campus - Coordinate [[29.7199489,-95.3422334]])(within 5 miles)
------------------------------------------------------------------
Here in below Query 3959 is for miles. and 29.7199489(Latitude) & -95.3422334(Longitude).

SELECT name,( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) AS distance,lat,lng,nodeType 
FROM pokemongo_hive 
WHERE ( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) < 5 
GROUP BY name,lat,lng,nodeType
ORDER BY distance;

------------------------------------------------------------------
ALL Pokestops within 5 Miles from Main Campus - Coordinate [[29.7199489,-95.3422334]])(within 5 miles)
------------------------------------------------------------------
SELECT name,( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) AS distance,nodeType 
FROM pokemongo_hive 
WHERE ( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) < 5 AND nodeType="Pokestops" 
GROUP BY name,lat,lng,nodeType
ORDER BY distance;

------------------------------------------------------------------
ALL Gyms within 5 Miles from Main Campus - Coordinate [[29.7199489,-95.3422334]])(within 5 miles)
------------------------------------------------------------------
SELECT name,( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) AS distance,nodeType 
FROM pokemongo_hive 
WHERE ( 3959 * acos( cos( radians(29.7199489) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians(-95.3422334) ) + sin( radians(29.7199489) ) * sin( radians(lat)))) < 5 AND nodeType="Gyms" 
GROUP BY name,lat,lng,nodeType
ORDER BY distance;

------------------------------------------------------------------
Find out which university has the largest number of Pokestops in Houston area.
------------------------------------------------------------------
select d.name as name, count(*) as counter,nodeType from pokemongo_hive d where nodeType LIKE '%Pokestops%' AND d.name LIKE '%University%' group by d.name,d.nodeType order by counter desc LIMIT 1;

------------------------------------------------------------------
Pokestops in different universities in Houston Area
------------------------------------------------------------------
select d.name as name, count(*) as counter,nodeType from pokemongo_hive d where nodeType LIKE '%Pokestops%' AND d.name LIKE '%University%' group by d.name,d.nodeType order by counter desc;

STEP 9 ENDS

Step 13: Starts
---------------------------------------------------------------------
Hive Tables for OpenStreetMap Data (nodes and ways tables of Hbase to Hive)
---------------------------------------------------------------------

CREATE EXTERNAL TABLE nodes_hive(key string, lat FLOAT, lng FLOAT, nodeId string, tags string)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = "nodeData:lat,nodeData:lng,nodeData:nodeId,nodeData:tags")
TBLPROPERTIES("hbase.table.name" = "nodes");
---------------------------------------------------------------------

CREATE EXTERNAL TABLE ways_hive(key string, nodes string, tags string)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = "wayData:nodes,wayData:tags")
TBLPROPERTIES("hbase.table.name" = "ways");
---------------------------------------------------------------------
Step 13: ENDS

Step 14: Starts

select * from ways_hive;
select * from nodes_hive;

Step 14 ENDS

Step 15 Starts
select nodes from ways_hive where tags LIKE '%Gymnasium%';
select nodes,tags from ways_hive where tags LIKE '%Gymnasium%';
Step 15 ENDS

/*--Optional Step In order to direcly analyzing the data without hbase loading*/
CREATE EXTERNAL TABLE IF NOT EXISTS pokemongo (
name STRING,
lat FLOAT,
lng FLOAT,
nodeType STRING
)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/input/fi/pokemongo';

---------------------------------------------
load data local inpath '/home/adithya/w/pokemon/parsed-pokemongo.txt' into table pokemongo;
---------------------------------------------



