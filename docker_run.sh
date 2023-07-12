docker run -dit --name=pim_ml --restart=always -v $HOME/dev:/root/dev \
-v /data:/data -v /home/user/upmem-sdk/upmem-2021.3.0-Linux-x86_64:/root/upmem-sdk/ \
-v /dev:/dev ubuntu:20.04 /bin/bash
docker exec --init -it pim_ml bash

#

apt-get install
apt-get install -y --no-install-recommends ca-certificates python3-dev g++ gcc make cmake openssh-server git wget curl vim libelf-dev libedit-dev libnuma-dev
apt-get install -y --no-install-recommends zsh language-pack-en python3-pygmentize
# region에서 seoul 선택

# zsh로 쉘 변경
chsh -s /usr/bin/zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions 
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git config --global oh-my-zsh.hide-status 1
git config --global oh-my-zsh.hide-dirty 1
# edit ~/.zshrc
ZSH_THEME="agnoster"
plugins=(git sudo common-aliases command-not-found zsh-autosuggestions zsh-syntax-highlighting)

# switch dict.iteritems to dict.items

docker run -dit --restart=always --privileged -v $HOME/dev:/root/dev \
-v /data:/data -v /home/user/upmem-sdk/upmem-2021.3.0-Linux-x86_64:/root/upmem-sdk/ \
pim_ml_image zsh


docker build -t df-upmem-kmeans ./Dockerfile
docker run -dit --restart=always --privileged -v $HOME/dev:/root/dev \
df-upmem-kmeans /bin/bash

docker build -t df-upmem-kmeans ./Dockerfile
docker run -dit --restart=always --privileged --device=/dev/dri \
--ipc=host --shm-size 16G \
--security-opt seccomp:unconfined \
--cap-add=ALL --privileged \
--group-add plugdev -v $HOME/dev:/root/dev df-upmem-kmeans /bin/bash



cd /home/user/upmem-sdk/upmem-2021.3.0-Linux-x86_64/
source upmem_env.sh
cd ~/dev/pim-ml/Linear_Regression/LinReg_no_quantization/LogReg_int32_float
python3 run_weak.py LRGD


docker build -t upmem-img .
docker run --group-add plugdev --user 0:1 -dit --network=host --device=/dev/dri --ipc=host \
--shm-size 16G --security-opt seccomp:unconfined --cap-add=ALL --privileged --name=upmem-lapis \
-v $HOME/dev:/root/dev upmem-img /bin/bash

cd ~/dev/pim-ml/Linear_Regression/LinReg_no_quantization/LogReg_int32_float
python3 run_weak.py LRGD