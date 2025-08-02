# Example Spark Job
from pyspark.sql import SparkSession


def main():

	spark = SparkSession.builder.appName('HelloSpark').getOrCreate()

	rdd = spark.sparkContext.parallelize('Hello, World!')

	for msg in rdd.collect():
		print(msg)
	
	spark.stop()

if __name__ == '__main__':
	main()
