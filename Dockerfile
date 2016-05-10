from randalburns/pvcat:pv501ubu16

# remove proxies
ENV http_proxy=''
ENV https_proxy=''
ENV HTTP_PROXY=''
ENV HTTPS_PROXy=''
ENV ALL_PROXY=''

# follow instructions in https://github.com/docker/docker/issues/5663
RUN sed -ri 's/^session\s+required\s+pam_loginuid.so$/session optional pam_loginuid.so/' /etc/pam.d/sshd

# create a vpic user
RUN groupadd -r vpic && useradd -r -m -g vpic vpic

# setup ssh keys and config
COPY id_rsa /home/vpic/.ssh/
COPY id_rsa.pub /home/vpic/.ssh/
COPY config /home/vpic/.ssh/
RUN chown -R vpic:vpic /home/vpic/.ssh; chmod 0700 /home/vpic/.ssh; chmod 0600 /home/vpic/.ssh/*
RUN sed -i 's/Port 22/Port 9222/' /etc/ssh/sshd_config

# add no password login
RUN cat /home/vpic/.ssh/id_rsa.pub >> /home/vpic/.ssh/authorized_keys

RUN chown -R vpic:vpic /home/vpic


# get more recent cmake as required for vpic
RUN mkdir /usr/local/cmake-3
WORKDIR /usr/local/cmake-3
RUN wget  https://cmake.org/files/v3.5/cmake-3.5.2-Linux-x86_64.tar.gz
RUN tar -xzf cmake-3.5.2-Linux-x86_64.tar.gz
ENV PATH /usr/local/cmake-3/cmake-3.5.2-Linux-x86_64/bin:$PATH


USER vpic
WORKDIR /home/vpic

#RUN git clone --recursive https://github.com/losalamos/vpic.git
RUN git clone https://github.com/demarle/vpic.git
WORKDIR /home/vpic/vpic
RUN git checkout -b dockerify origin/dockerify
RUN git submodule init
RUN git submodule update

# RBTODO move this to runvpic.sh
#RUN mkdir /home/vpic/vpic.bin
#WORKDIR /home/vpic/vpic.bin
#RUN cmake \
#  -DUSE_CATALYST=ON \
#  -DCMAKE_BUILD_TYPE=Release \
#  /home/vpic/vpic
#RUN make -j16

# add the launcher scripts for the docker file
ADD launch.sh /home/vpic
ADD launch_sshd.sh /home/vpic
ADD runvpic.sh /home/vpic
ADD machinefile /home/vpic

WORKDIR /home/vpic

USER root
