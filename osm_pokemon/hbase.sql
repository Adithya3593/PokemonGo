
Step 4:
create 'pokemongo','cf'

Step 5:
export HADOOP_CLASSPATH=`hbase classpath`
hadoop jar pokemonDataLoader.jar /input/fi/pokemongo/parsed-pokemon.txt /output/pokemongo

Step 10:
create 'nodes','nodeData'
create 'ways','wayData'