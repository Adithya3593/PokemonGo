/**
 * 
 */
package com.work.osm_pokemon.parser.pokemonkml;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.work.osm_pokemon.util.FileUtil;

import de.micromata.opengis.kml.v_2_2_0.Boundary;
import de.micromata.opengis.kml.v_2_2_0.Coordinate;
import de.micromata.opengis.kml.v_2_2_0.Document;
import de.micromata.opengis.kml.v_2_2_0.Feature;
import de.micromata.opengis.kml.v_2_2_0.Folder;
import de.micromata.opengis.kml.v_2_2_0.Geometry;
import de.micromata.opengis.kml.v_2_2_0.Kml;
import de.micromata.opengis.kml.v_2_2_0.LinearRing;
import de.micromata.opengis.kml.v_2_2_0.Placemark;
import de.micromata.opengis.kml.v_2_2_0.Point;
import de.micromata.opengis.kml.v_2_2_0.Polygon;

/**
 * @author ubuntu
 *
 */
public class KMLParser
{

	/**
	 * @param args
	 */
	static List<String> lines = new ArrayList<String>();
	
	public static void main(String[] args)
	{
		// TODO Auto-generated method stub
		try
		{
			if(args.length ==2){
				parseKml(args);	
			}
			else{
				System.err.println("USAGE:<INPUT_PATH> <OUTPUT_FILE_PATH>");
			}
			
			
		}
		catch(Exception exception)
		{
			exception.printStackTrace();
		}
	}

	public static void parseKml(String[] args)
	{
		String src = args[0];
//		String src = 
		
		Kml kml = Kml.unmarshal(new File(src));
		Feature feature = kml.getFeature();
		parseFeature(feature,args[1]);
	}

	private static void parseFeature(Feature feature,String outputFilePath)
	{
		if(feature != null)
		{
			if(feature instanceof Document)
			{
				Document document = (Document) feature;
				System.out.println("Document Name::"+document.getName());
				List<Feature> featureList = document.getFeature();
				
				for (Feature documentFeature : featureList)
				{

					if(documentFeature instanceof Folder)
					{
						Folder folder = (Folder) documentFeature;
						List<Feature> folderFeatureList = folder.getFeature();
						System.out.println("Folder::"+folder.getName());
						for(Feature folderFeature : folderFeatureList){
							
							if(folderFeature instanceof Placemark)
							{
								Placemark placemark = (Placemark) folderFeature;
//								System.out.println("PlaceMarkName::"+placemark.getName());
								if(null != placemark.getDescription())
								System.out.println(placemark.getDescription());
								Geometry geometry = placemark.getGeometry();
								parseGeometry(geometry,placemark.getName(),folder.getName());
							}
							
						}
						
					}

				}
				
				//Dumping Lines to  Txt file...
				FileUtil.writeFileFromList(outputFilePath, lines);
				
//				FileUtil.writeFileFromList("/home/w/pokemon/lines.txt",lines);
				
				System.out.println("Done.");
			}
		}
	}

	private static void parseGeometry(Geometry geometry,String name,String type)
	{
		if(geometry != null)
		{
			if(geometry instanceof Point)
			{
				
				Point point = (Point) geometry;
				List<Coordinate> coordinates=point.getCoordinates();
				
				if(coordinates != null)
				{
					for (Coordinate coordinate : coordinates)
					{
						parseCoordinate(coordinate,name,type);
					}
				}
				
			}
			//This case is for Polygon it is not being used for now.
			else if(geometry instanceof Polygon){
				
				Polygon polygon = (Polygon) geometry;
				Boundary outerBoundaryIs = polygon.getOuterBoundaryIs();
				if(outerBoundaryIs != null)
				{
					LinearRing linearRing = outerBoundaryIs.getLinearRing();
					if(linearRing != null)
					{
						List<Coordinate> coordinates = linearRing.getCoordinates();
						if(coordinates != null)
						{
							for (Coordinate coordinate : coordinates)
							{
								parseCoordinate(coordinate,name,type);
							}
						}
					}
				}
				
			}
		}
	}

	private static void parseCoordinate(Coordinate coordinate,String name,String type)
	{
		if(coordinate != null)
		{
			lines.add(name+"\t"+coordinate.getLatitude()+"\t"+coordinate.getLongitude()+"\t"+type);
//			System.out.println("Longitude: " + coordinate.getLongitude()+"\t Latitude : " + coordinate.getLatitude());
			/*System.out.println("Latitude : " + coordinate.getLatitude());*/
			/*System.out.println("Altitude : " + coordinate.getAltitude());*/
/*			System.out.println("");*/
		}
	}

}
