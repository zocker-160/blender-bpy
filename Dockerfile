FROM ubuntu:20.04

MAINTAINER zocker_160

ENV DEBIAN_FRONTEND noninteractive

ARG PYTHON_VER_MAJ=3.10
ARG PYTHON_VER=3.10.2

ARG BLENDER_VERSION=3.0

ENV PYTHON_SITE_PACKAGES /usr/local/lib/python$PYTHON_VER_MAJ/site-packages/
ENV WITH_INSTALL_PORTABLE OFF

RUN apt-get update
RUN apt-get -y install \
    build-essential \
    cmake \
    curl \
    git \
    subversion \
    sudo \
    ncdu \
    zlib1g zlib1g-dev

# official Blender deps
RUN apt-get install -y build-essential git subversion cmake libx11-dev libxxf86vm-dev libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libglew-dev

# install python
WORKDIR /home/tmp/python
ADD https://www.python.org/ftp/python/$PYTHON_VER/Python-$PYTHON_VER.tgz Python.tgz
RUN tar xzf Python.tgz
WORKDIR /home/tmp/python/Python-$PYTHON_VER
RUN ./configure --enable-optimizations
#RUN ./configure
RUN make -j$(nproc) install

#RUN apt-get install -y python3.10

WORKDIR /home/tmp/lib
RUN svn checkout https://svn.blender.org/svnroot/bf-blender/trunk/lib/linux_centos7_x86_64

WORKDIR /home/tmp
RUN git clone https://git.blender.org/blender.git # -b v3.1.2

WORKDIR /home/tmp/blender
RUN git submodule update --init --recursive

#RUN bash ./build_files/build_environment/install_deps.sh

#RUN make update
#RUN make
RUN make bpy

WORKDIR /home/tmp/blender/build_linux_bpy
RUN ls -l
RUN cmake .. \
    -DPYTHON_SITE_PACKAGES=/usr/local/lib/python$PYTHON_VER_MAJ/site-packages/ \
    -DWITH_INSTALL_PORTABLE=OFF \
    -DWITH_PYTHON_INSTALL=OFF \
    -DWITH_PLAYER=OFF \
    -DWITH_PYTHON_MODULE=ON \
    -DWITH_MEM_JEMALLOC=OFF # workaround for some weird TLS import bug
RUN make install -j$(nproc)

#RUN ls -l /home/tmp/build_linux_bpy/bin

# move files into position
#RUN cp /home/tmp/build_linux_bpy/bin/bpy.so /usr/local/lib/python$PYTHON_VER_MAJ/site-packages
#RUN cp -r /home/tmp/build_linux_bpy/bin/$BLENDER_VERSION /usr/local/lib/python$PYTHON_VER_MAJ/site-packages

#RUN cp -r /home/tmp/lib/linux_centos7_x86_64/python/lib/python$PYTHON_VER_MAJ/site-packages/$BLENDER_VERSION /usr/local/lib/python$PYTHON_VER_MAJ/site-packages/

#WORKDIR /bpy
#RUN mv /home/tmp/build_linux_bpy/bin/bpy.so .
#RUN mv /home/tmp/lib/linux_centos7_x86_64/python/lib/python$PYTHON_VER_MAJ/site-packages/$BLENDER_VERSION .

# cleanup
RUN rm -rf /home/tmp

WORKDIR /home

# test if it works
RUN python3 -c "import bpy;print(dir(bpy.types));print(bpy.app.version_string);"

CMD bash

#RUN python3 -c "import bpy;print(dir(bpy.types));"

#FROM python:3.7.9-buster

#RUN apt-get update && apt-get install -y sudo

#COPY --from=builder /home/docker/build_linux_bpy/bin/bpy.so /usr/local/lib/python3.7/site-packages
#COPY --from=builder /home/docker/lib/linux_centos7_x86_64/python/lib/python3.7/site-packages/2.91 /usr/local/lib/python3.7/site-packages/

#WORKDIR /tmp
#ADD https://raw.githubusercontent.com/sobotka/blender/master/build_files/build_environment/install_deps.sh install_deps.sh
#RUN chmod +x install_deps.sh && ./install_deps.sh

#WORKDIR /home/blender

#CMD bash
