# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/net-www/zope/zope-2.2.4.ebuild,v 1.3 2001/08/07 18:47:13 drobbins Exp $

A="zope_${PV}.orig.tar.gz zope_${PV}-3.diff.gz"
S=${WORKDIR}/Zope-${PV}-src
DESCRIPTION="Zope is web application platform used for building high-performance, dynamic web sites."
SRC_URI="http://ftp.debian.org/debian/pool/main/z/zope/zope_${PV}.orig.tar.gz
	 http://ftp.debian.org/debian/pool/main/z/zope/zope_${PV}-3.diff.gz"
HOMEPAGE="http://www.zope.org"

DEPEND="virtual/glibc dev-lang/python"
src_unpack() {

    unpack zope_2.2.4.orig.tar.gz
    cd ${S}
    gzip -dc ${DISTDIR}/zope_2.2.4-3.diff.gz | patch -p1
    cd lib/Components/cPickle
    cp cPickle.c cPickle.orig
    sed -e "s:#include \"mymath.h\"::" \
	cPickle.orig > cPickle.c
}

src_compile() {

    try python w_pcgi.py
}

src_install () {

    ZDIR=/usr/lib/zope
    ZVAR=/var/lib/zope

    dodir ${ZDIR}/lib/python
    cp -a lib/python/* ${D}${ZDIR}/lib/python
    cp -a ZServer utilities ${D}${ZDIR}
    rm ${D}${ZDIR}/ZServer/*.txt
    exeinto ${ZDIR}/pcgi
    doexe pcgi/pcgi-wrapper pcgi/pcgi_publisher.py

    find ${D}${ZDIR} -regex "Makefile\.*" \
	-o -regex ".+\.[cho]" \
	-o -regex ".+\.pyc" \
	-o -name config.c -o -name sedscript \
	-o -name Setup -o -name Setup.in \
	-exec rm {} \;

    find ${D}${ZDIR}/lib/python/Shared/DC/xml/pyexpat \
	-regex ".+\.h" -exec rm {} \;

    cd ${D}${ZDIR}/lib/python/Shared/DC/xml/pyexpat
    rm -rf pyexpat.prj* expat

    cd ${S}/lib
    insinto ${ZDIR}/lib/Components/ExtensionClass
    doins Components/ExtensionClass/ExtensionClass.h
    insinto ${ZDIR}/lib/python/ZODB
    doins python/ZODB/cPersistence.h

    cd ${S}
    fperms a+x ${ZDIR}/lib/python/zdaemon.py 
    fperms a+x	${ZDIR}/lib/python/StructuredText/StructuredText.py
    fperms a+x	${ZDIR}/lib/python/ZPublisher/Client.py

    dodir ${ZVAR}
    insinto ${ZVAR}/var
    insopts -m644
    doins var/Data.fs.in

    exeinto /usr/sbin
    doexe debian/zopectl
    exeinto ${ZDIR}
    doexe z2.py zpasswd.py
    dosym ${ZDIR}/z2.py /usr/sbin/zope-z2
    dosym ${ZDIR}/zpasswd.py /usr/sbin/zope-zpasswd
    exeinto /usr/lib/cgi-bin
    newexe debian/Zope.cgi Zope
}

pkg_postinst() {
    if [ ! -f ${ROOR}/var/lib/zope/var/Data.fs ]
    then
      echo "Installing Data.fs from template..."
      cd ${ROOT}/var/lib/zope/var
      cp Data.fs.in Data.fs
      echo
      echo "Fixing permissions..."
      chown nobody.nogroup -R ${ROOT}/var/lib/zope/var
      chmod 600 ${ROOT}/var/lib/zope/var/Data.fs
      echo
    fi
    if [ ! -f ${ROOT}/var/lib/zope/access ]
    then
      echo "You must run"
      echo
      echo zope-zpasswd /var/lib/zope/access
      echo
      echo before you can start zope
    fi
}
