# blender-docker-bpy

Blender as Python module in a Docker container

### Run using Docker
#### Use prebuilt Docker Container

```bash
docker run -it zocker160/blender-bpy
```

##### Docker Tags
// TODO

#### Build container yourself

```bash
git clone https://github.com/zocker-160/blender-docker-bpy.git
docker build . -f Dockerfile -t blender:bpy
docker run -it --name bpy blender:bpy
```

### How to run locally

#### Install Python

**NOTE**: replace the Python version with the appropriate one needed for each version of Blender!

```bash
wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz -O Python.tgz
tar xzf Python.tgz
cd Python-3.7.7/
./configure --enable-optimizations
sudo make install

# if you want to install Python 3.7.7 alongside other versions, then use instead:
sudo make altinstall
```

#### Install Bpy module (precompiled)

- Download precompiled module from [Releases · zocker-160/blender-docker-bpy · GitHub](https://github.com/zocker-160/blender-docker-bpy/releases)
- unzip
- copy `bpy.so` and the folder to `/usr/local/lib/python3.7/site-packages/`

#### Compile Bpy module

```bash
git clone https://github.com/zocker-160/blender-docker-bpy.git
make
```

- copy files from `bpy` folder to `/usr/local/lib/python3.7/site-packages/`
- cleanup with `make clean`
- *(optional)* test installation with `python3 bpytest.py`
