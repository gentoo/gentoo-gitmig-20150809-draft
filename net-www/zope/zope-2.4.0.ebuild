# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Holger Brueckner <darks@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/zope/zope-2.4.0.ebuild,v 1.1 2001/08/05 21:23:11 darks Exp $

A="Zope-${PV}-src.tgz"
S=${WORKDIR}/Zope-${PV}-src
DESCRIPTION="Zope is web application platform used for building high-performance, dynamic web sites."
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz"
HOMEPAGE="http://www.zope.org"

DEPEND="virtual/glibc 
        >=dev-lang/python-2.1"
RDEPEND=">=dev-lang/python-2.1"

src_unpack() {

    unpack Zope-${PV}-src.tgz
}

src_compile() {

    try python w_pcgi.py
}

src_install () {

    ZDIR=/usr/share/zope
    ZVAR=/var/lib/zope
    
    
    dodir ${ZDIR}/var
    insinto ${ZDIR}
    doins w_pcgi.py wo_pcgi.py 
     
    dodir ${ZDIR}/lib
    cp -a lib/* ${D}${ZDIR}/lib/
    cp -a ZServer utilities ${D}${ZDIR}
    rm ${D}${ZDIR}/ZServer/*.txt
    exeinto ${ZDIR}/pcgi
    doexe pcgi/pcgi-wrapper pcgi/pcgi_publisher.py

    dodir ${ZDIR}/inst
    cp -a inst/* ${D}${ZDIR}/inst

    dodir ${ZDIR}/pcgi
    cp -a pcgi/* ${D}${ZDIR}/pcgi
    
    cd ${S}
    fperms a+x ${ZDIR}/lib/python/zdaemon.py 
    fperms a+x	${ZDIR}/lib/python/StructuredText/StructuredText.py
    fperms a+x	${ZDIR}/lib/python/ZPublisher/Client.py

    dodir ${ZVAR}
    insinto ${ZVAR}/var
    doins z2.py
    insopts -m644
    doins var/Data.fs.in
    dodir ${ZVAR}/Extensions
    dodir ${ZVAR}/import
    dodir ${ZVAR}/Products

    exeinto ${ZDIR}
    doexe zpasswd.py start stop Zope.cgi
    
    cd ${D}${ZDIR}
    sed -e "s:${WORKDIR}:${ZDIR}:g" Zope.cgi > Zope.cgi.tmp
    mv Zope.cgi.tmp Zope.cgi
    sed -e "s:${WORKDIR}:${ZVAR}:g" stop > stop.tmp
    mv stop.tmp stop
    
    dodir /etc/rc.d/init.d
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/zope
}

pkg_postinst() {
    if [ ! -f ${ROOT}/var/lib/zope/var/Data.fs ]
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
      echo /usr/share/zope/zpasswd.py /var/lib/zope/inituser
      echo
      echo before you can start zope
    fi
}
