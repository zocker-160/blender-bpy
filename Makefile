build:
	docker build . -f Dockerfile -t blender:bpy
	docker run --rm -it -d --name bpy blender:bpy
	docker cp bpy:/bpy .
master:
	docker build . -f Dockerfile.master -t blender:bpy
	docker run --rm -it -d --name bpy blender:bpy
	docker cp bpy:/bpy .
clean:
	docker stop bpy
	docker rm blender:bpy
