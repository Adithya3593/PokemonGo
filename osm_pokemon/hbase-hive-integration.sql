STEP:7

Get all required files from Hive 

zookeeper-*.jar          //This will be present in $HIVE_HOME/lib directory
hive-hbase-handler-*.jar //This will be present in $HIVE_HOME/lib directory
guava-*.jar              //This will be present in $HIVE_HOME/lib director 
hbase-*.jar files       //This will be present in $HBASE_HOME/lib directory

My Path:

file:///usr/local/hive/apache-hive-1.0.0-bin/lib/zookeeper-3.4.5.jar
file:///usr/local/hive/apache-hive-1.0.0-bin/lib/hive-hbase-handler-1.0.0.jar
file:///usr/local/hive/apache-hive-1.0.0-bin/lib/guava-11.0.2.jar

Required HBase Files:
 
hbase-client-*-hadoop2.jar
hbase-common-*-hadoop2.jar
hbase-hadoop2-compat-*-hadoop2.jar
hbase-it-*-hadoop2.jar
hbase-prefix-tree-*-hadoop2.jar
hbase-protocol-*-hadoop2.jar
hbase-server-*-hadoop2.jar
hbase-shell-*-hadoop2.jar
hbase-thrift-*-hadoop2.jar

My HBase File PATH:

file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-client-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-common-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-hadoop2-compat-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-it-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-prefix-tree-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-protocol-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-server-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-shell-0.98.16.1-hadoop2.jar
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-thrift-0.98.16.1-hadoop2.jar


We need to add the paths of above jars files to the value of hive.aux.jar.path in hive-site.xml file

file:///usr/local/hive/apache-hive-1.0.0-bin/lib/zookeeper-3.4.5.jar,
file:///usr/local/hive/apache-hive-1.0.0-bin/lib/hive-hbase-handler-1.0.0.jar,
file:///usr/local/hive/apache-hive-1.0.0-bin/lib/guava-11.0.2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-client-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-common-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-hadoop2-compat-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-it-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-prefix-tree-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-protocol-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-server-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-shell-0.98.16.1-hadoop2.jar,
file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-thrift-0.98.16.1-hadoop2.jar


Place below property in Hive hive-site.xml file.

<property>
    <name>hive.aux.jars.path</name>
    <value>
    file:///usr/local/hive/apache-hive-1.0.0-bin/lib/zookeeper-3.4.5.jar,file:///usr/local/hive/apache-hive-1.0.0-bin/lib/hive-hbase-handler-1.0.0.jar,file:///usr/local/hive/apache-hive-1.0.0-bin/lib/guava-11.0.2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-client-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-common-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-hadoop2-compat-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-it-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-prefix-tree-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-protocol-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-server-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-shell-0.98.16.1-hadoop2.jar,file:///usr/lib/hbase/hbase-0.98.16.1-hadoop2/lib/hbase-thrift-0.98.16.1-hadoop2.jar
    </value>
</property>


HBase Hive integration table:


This is just for NOTE which is not intented to our Project OSM PokemonGO

CREATE TABLE hbase_table_emp(id int, name string, role string) 
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = ":key,cf1:name,cf1:role")
TBLPROPERTIES ("hbase.table.name" = "emp");


We can not directly load the data into hbase table 'emp' with the load data inpath hive command. we have to copy data into it from another hive table,
Lets create another test hive table with same schema hbase_table_emp and we will insert records into it with hive load data input command.


hive> create table testemp(id int, name string, role string) row format delimited fields terminated by '\t';
hive> load data local inpath '/home/adithya/w/emp.txt' into table testemp;
hive> select * from testemp;

lets copy contents into hbase_table_emp table from testemp and varify its content

hive> insert overwrite table hbase_table_emp select * from testemp;
hive> select * from hbase_table_emp;

Similar to creating new HBase tables, we can also map HBase existing tables to Hive. To give Hive access to an existing HBase table with multiple columns and families, 
we need to use CREATE EXTERNAL TABLE. But, hbase.columns.mapping is required and it will be validated against the existing HBase tables column families, whereas
hbase.table.name is optional
For testing this, we will create 'user' table in HBase as shown below and map this to Hive table.


hbase(main):002:0> create 'user', 'cf1', 'cf2'
hbase(main):003:0> put 'user', 'row1', 'cf1:a', 'value1'
hbase(main):004:0> put 'user', 'row1', 'cf1:b', 'value2'
hbase(main):005:0> put 'user', 'row1', 'cf2:c', 'value3'
hbase(main):006:0> put 'user', 'row2', 'cf2:c', 'value4'
hbase(main):007:0> put 'user', 'row2', 'cf1:b', 'value5'
hbase(main):008:0> put 'user', 'row3', 'cf1:a', 'value6'
hbase(main):009:0> put 'user', 'row3', 'cf2:c', 'value7'
hbase(main):010:0> describe 'user'
hbase(main):011:0> scan 'user'

Lets create corresponding Hive table for the above 'user' Hbase table. 
Below is the DDL for creation of external table


$ hive
hive> CREATE EXTERNAL TABLE hbase_table_user(key string, val1 string, val2 string, val3 string)
STORED BY 'org.apache.hadoop.hive.hbase.HBaseStorageHandler'
WITH SERDEPROPERTIES ("hbase.columns.mapping" = "cf1:a,cf1:b,cf2:c")
TBLPROPERTIES("hbase.table.name" = "user");


hive> DESCRIBE hbase_table_user;
hive> SELECT * FROM hbase_table_user;




