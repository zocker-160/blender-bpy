build:
	docker build . -f Dockerfile.builder -t blender:bpy
	docker run --rm -d --name bpy blender:bpy tail -f /dev/null
	docker cp bpy:/bpy .
	docker kill bpy
stable:
	docker build . -f Dockerfile-stable.builder -t blender:bpy
	docker run --rm -d --name bpy blender:bpy tail -f /dev/null
	docker cp bpy:/bpy .
	docker kill bpy
clean:
	docker rm blender:bpy
	rm -rf ./bpy
