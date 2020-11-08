build:
	docker build . -f Dockerfile.builder -t blender:bpy
	docker run --rm -d --name bpy blender:bpy
	docker cp bpy:/bpy .
stable:
	docker build . -f Dockerfile-stable.builder -t blender:bpy
	docker run --rm -d --name bpy blender:bpy
	docker cp bpy:/bpy .
clean:
	docker rm blender:bpy
	rm -rf ./bpy
