/**
 * 
 */
package com.work.osm_pokemon.util;

import java.io.PrintWriter;
import java.util.List;


public class FileUtil
{
	public static void writeFileFromList(String filePath,List<String> lines)
	{
		try
		{
			PrintWriter writer = new PrintWriter(filePath, "UTF-8");
			
			for(String line : lines){
				writer.write(line+"\n");
			}

			writer.close();

		}
		catch(Exception exception)
		{
			exception.printStackTrace();

		}

	}
}
