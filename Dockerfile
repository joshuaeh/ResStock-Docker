# syntax=docker/dockerfile:1
# Dockerfile for Resstock3.2.0
# Author: Joshua Hammond joshua.hammond@utexas.edu
# Date: 2024-01-23

# Dependencies:
# OpenStudio v3.7.0  
# EnergyPlus v23.2  
# buildstockbatch v2023.10.0  
# OpenStudio-HPXML v1.7.0  

# Start with existing NREL OpenStudio Image 
# See https://github.com/NREL/docker-openstudio
# Includes EnergyPlus and Ruby
# OpenStudio-3.7.0 is installed in /usr/local/openstudio-3.7.0
FROM nrel/openstudio:3.7.0 AS base

# Add OPENSTUDIO_EXE to environment
ENV OPENSTUDIO_EXE=/usr/local/openstudio-3.6.1/bin/openstudio

# Set shell to bash 
SHELL ["/bin/bash", "-c"]

# update OS and get packages
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN sudo apt update && \
    sudo DEBIAN_FRONTEND=noninteractive sudo apt install -y wget build-essential checkinstall libreadline-gplv2-dev libncursesw5-dev libssl-dev \
    libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

# Install miniconda to /opt/conda
ENV CONDA_DIR /opt/conda
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda
ENV PATH=$CONDA_DIR/bin:$PATH
RUN conda update -n base -c defaults conda

# clone repositories to /home/resstock/ and install buildstockbatch
RUN git clone --branch v1.7.0 https://github.com/NREL/OpenStudio-HPXML.git /home/resstock/openstudio-hpxml/
RUN git clone --branch v3.2.0 https://github.com/NREL/resstock.git /home/resstock/resstock
RUN git clone --branch v2023.10.0 https://github.com/NREL/buildstockbatch.git /home/resstock/buildstockbatch
RUN pip install -e /home/resstock/buildstockbatch

# clean up installation files 
RUN rm /ruby-2.7.2.tar.gz
RUN rm /OpenStudio-3.6.1+bb9481519e-Ubuntu-20.04-x86_64.deb

WORKDIR /home/resstock
