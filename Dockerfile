FROM balenalib/raspberrypi3:build

# Switch into our apps working directory
WORKDIR /build
COPY . /build

RUN [ "cross-build-start" ]

RUN apt-get update  
RUN apt-get install git-buildpackage debhelper libasound2-dev libgps-dev dh-systemd fakeroot
RUN git checkout debian
RUN gbp buildpackage --git-upstream-branch=master --git-debian-branch=debian --git-upstream-tree=BRANCH --git-ignore-new --git-builder='debuild -i -I -uc -us'
RUN mkdir ../pkgs
RUN cp ../direwolf* ../pkgs

RUN [ "cross-build-end" ]  
