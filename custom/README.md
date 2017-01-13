Customized Docker Images for Confluent Plaform
===

This directory offers severale examples that extend the default
ConfluentPlatform images.   For example, the kafka-connect image
is extended with some additional Kafka Connect jars.

To build the images, simply issue the command.
	docker build -t <docker_tag> <image_directory>

Tagging the image with your own unique value is important to avoid 
namespace collision with the core Confluent Platform docker images.

For example, the customized kafka-connect image was tested via
	docker build -t dbtucker/cp-kafka-connect:3.x  kafka-connect

The generated image (dbtucker/cp-kafka-connect:3.x in the above example)
can be used directly on your development environment or pushed to 
Docker Hub for use elsewhere:
	docker push <docker_tag>

<h2>
Custom Kafka Connect
</h2>



<h2>
Custom Confluent Platform Quickstart
</h2>
The quickstart image includes ALL of the Confluent Platform components


