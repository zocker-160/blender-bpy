# blender-docker-bpy

Blender as Python module in a Docker container

### How to install

#### Install Python

```bash
wget https://www.python.org/ftp/python/3.7.7/Python-3.7.7.tgz -O Python.tgz
tar xzf Python.tgz
cd Python-3.7.7/
./configure --enable-optimizations
sudo make install
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
