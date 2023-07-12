ARG VARIANT="focal"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}
RUN sudo apt update \
    && sudo apt -y install python-is-python3 pip build-essential cmake ninja-build cppcheck ca-certificates openssh-server git wget curl vim tmux \
    && sudo apt full-upgrade -y
RUN sudo apt update \
    && wget http://sdk-releases.upmem.com/2021.3.0/ubuntu_20.04/upmem_2021.3.0_amd64.deb \
    && sudo apt install -y ./upmem_2021.3.0_amd64.deb
RUN pip3 install tqdm