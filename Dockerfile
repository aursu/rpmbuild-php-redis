ARG centos=7.9.2009
ARG image=php-igbinary-7.4

FROM aursu/peclbuild:${centos}-${image}

RUN yum -y install \
        redis \
        liblzf-devel \
    && yum clean all && rm -rf /var/cache/yum

COPY SOURCES ${BUILD_TOPDIR}/SOURCES
COPY SPECS ${BUILD_TOPDIR}/SPECS

RUN chown -R $BUILD_USER ${BUILD_TOPDIR}/{SOURCES,SPECS}

USER $BUILD_USER

ENTRYPOINT ["/usr/bin/rpmbuild", "php-pecl-redis4.spec"]
CMD ["-ba"]
