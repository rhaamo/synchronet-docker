FROM ubuntu:19.10
MAINTAINER dashie <dashie@otter.sh>

ARG VERSION=317b
ENV SBBS_UID=1000
ENV SBBS_GID=1000
ENV SBBS_INIT_NODES=6

# Do not touch
ENV DEBIAN_FRONTEND noninteractive
ENV INITRD No
ENV SBBSCTRL /home/synchronet/sbbs/ctrl
ENV TERM dumb

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.build-date=$BUILD_DATE

# Patches
ADD ./wipremove.patch /tmp/wipremove.patch

# Install prerequisites
RUN apt update && \
	apt install -y --no-install-recommends --fix-missing build-essential cvs wget libnspr4-dev libncurses5-dev liblhasa-dev && \
	apt install -y --no-install-recommends --fix-missing unzip zip python perl dosemu pkg-config libnspr4 gosu

# Install SynchroNet
RUN groupadd -r -g $SBBS_GID synchronet && useradd --no-log-init -r -u $SBBS_UID -g synchronet -d /home/synchronet -m synchronet

USER synchronet

RUN mkdir -p /home/synchronet/sbbs/data && cd /home/synchronet/sbbs && \
	wget ftp://vert.synchro.net/Synchronet/srun$VERSION.tgz && \
	wget ftp://vert.synchro.net/Synchronet/ssrc$VERSION.tgz && \
	tar xzf ssrc$VERSION.tgz && \
	tar xzf srun$VERSION.tgz && \
	patch -p0 < /tmp/wipremove.patch && \
	cd /home/synchronet/sbbs/src/sbbs3 && make USEDOSEMU=1 RELEASE=1 && \
	cd /home/synchronet/sbbs/xtrn/sbj && make && \
	cd /home/synchronet/sbbs/exec && \
	ln -s ../src/sbbs3/gcc.*.exe.release/* . && \
	ln -s ../src/sbbs3/*/gcc.*.exe.release/* . && \
	make

# Some default config
RUN echo "PATH=\$PATH:/home/synchronet/sbbs/exec" >> /home/synchronet/.bashrc && \
	mv /home/synchronet/sbbs/ctrl /home/synchronet/sbbs/ctrl-base && \
	mv /home/synchronet/sbbs/text /home/synchronet/sbbs/text-base

ADD ./entrypoint.sh /

# Cleaning
USER root
RUN apt remove -y build-essential cvs wget libnspr4-dev libncurses5-dev && \
	apt autoremove -y && \
	apt clean && \
	rm -f /tmp/wipremove.patch && \
	chown -R synchronet: /home/synchronet

VOLUME /home/synchronet/sbbs/data
VOLUME /home/synchronet/sbbs/ctrl
VOLUME /home/synchronet/sbbs/text

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/home/synchronet/sbbs/exec/sbbs"]	

WORKDIR /home/synchronet/sbbs

