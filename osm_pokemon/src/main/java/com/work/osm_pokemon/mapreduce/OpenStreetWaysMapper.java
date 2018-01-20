/**
 * 
 */
package com.work.osm_pokemon.mapreduce;

import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.hbase.client.Put;
import org.apache.hadoop.hbase.io.ImmutableBytesWritable;
import org.apache.hadoop.hbase.util.Bytes;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;
import org.apache.hadoop.mapreduce.Mapper.Context;

/**
 * @author ubuntu
 *
 */
public class OpenStreetWaysMapper extends Mapper<LongWritable, Text, ImmutableBytesWritable, Put> 
{
	
	private String hbaseTable; 
	
	private String dataSeperator;
	
	private String columnFamily1;
	
	private ImmutableBytesWritable hbaseTableName;
	
	public void setup(Context context) 
	{
		
		Configuration configuration = context.getConfiguration();
		
		hbaseTable = configuration.get("hbase.table.name");
		
		dataSeperator = configuration.get("data.seperator");
		
		columnFamily1 = configuration.get("COLUMN_FAMILY_1");
		
		hbaseTableName = new ImmutableBytesWritable(Bytes.toBytes(hbaseTable));
		
	}
	
	public void map(LongWritable key, Text value, Context context)
	{
		try
		{
		
			String[] values = value.toString().split(dataSeperator);
			
			String rowKey = values[0];
			
			Put put = new Put(Bytes.toBytes(rowKey));
			
			put.add(Bytes.toBytes(columnFamily1), Bytes.toBytes("id"), Bytes.toBytes(values[0]));
			
			put.add(Bytes.toBytes(columnFamily1), Bytes.toBytes("nodes"), Bytes.toBytes(values[6]));
			
			put.add(Bytes.toBytes(columnFamily1), Bytes.toBytes("tags"), Bytes.toBytes(values[7]));
			
			context.write(hbaseTableName, put);
			
		}
		catch(Exception exception)
		{
			
			exception.printStackTrace();
			
		}
		
	}

}
