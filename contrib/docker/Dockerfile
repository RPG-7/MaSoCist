FROM ghdl/ghdl:buster-gcc-7.2.0

RUN apt-get update ; \
	apt-get install -y xsltproc make git flex bison gperf wget bzip2 \
	libncurses-dev \
	python python-pip \
	minicom socat \
	screen gnupg sudo pkg-config autoconf libtool

# These are necessary to build netpp:
# RUN apt-get install -y libeditline-dev doxygen

RUN wget -qO - https://section5.ch/section5-apt.key | apt-key add - 

RUN echo "deb http://section5.ch/debian buster non-free" > /etc/apt/sources.list.d/section5.list

RUN apt-get update ; \
	apt-get install -y gensoc binutils-msp430 gcc-msp430 msp430-libc

# Install some python modules:
RUN pip install intelhex numpy

RUN useradd -u 1000 -g 100 -m -s /bin/bash masocist 
RUN echo "export LD_LIBRARY_PATH=\$HOME/src/vhdl/ghdlex/src:$LD_LIBRARY_PATH" >> /home/masocist/.bashrc

RUN adduser masocist sudo
RUN echo "masocist ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/masocist-nopw

COPY init-pty.sh /home/masocist
RUN chown masocist /home/masocist/init-pty.sh; \
	chmod a+x /home/masocist/init-pty.sh

USER masocist
WORKDIR /home/masocist

ENTRYPOINT ["/home/masocist/init-pty.sh"]