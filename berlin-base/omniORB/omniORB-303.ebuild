# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/berlin-base/omniORB/omniORB-303.ebuild,v 1.6 2001/05/03 19:33:52 achim Exp $

A="${PN}_${PV}.tar.gz omniORBpy_1_3.tar.gz"
S=${WORKDIR}/omni
DESCRIPTION="a robust, high-performance CORBA 2 ORB"
SRC_URI="ftp://ftp.uk.research.att.com/pub/omniORB/omniORB3/${PN}_${PV}.tar.gz
	 ftp://ftp.uk.research.att.com/pub/omniORB/omniORBpy/${PN}py_1_3.tar.gz"
HOMEPAGE="http://www.uk.research.att.com/omniORB/"

DEPEND=""

PLT="i586_linux_2.0_glibc2.1"

src_unpack() {

  unpack ${PN}_${PV}.tar.gz
  cd ${S}/src/lib
  unpack ${PN}py_1_3.tar.gz

  cd ${S}/config
  cp config.mk config.mk.orig
  sed -e "s:#platform = ${PLT}:platform = ${PLT}:" \
  config.mk.orig > config.mk

  cd ${S}/mk
  cp unix.mk unix.mk.orig
  sed -e "s:^MKDIRHIER.*:MKDIRHIER = mkdir -p:" unix.mk.orig > unix.mk

  cd platforms
  cp ${PLT}.mk ${PLT}.orig
  sed -e "s:#PYTHON = /usr.*:PYTHON=/usr/bin/python:" \
      ${PLT}.orig > ${PLT}.mk

}


src_compile() {

    cd src
    try make export
    cd src/lib/omniORBpy
    try make export
}

src_install () {

    T=/opt/berlin
    into ${T}
    cd ${S}
    dobin bin/${PLT}/* bin/scripts/*
    insinto ${T}/lib/idl
    doins idl/*.idl
    insinto ${T}/lib/idl/COS
    doins idl/COS/*.idl
    cp -af include ${D}/${T}
    dolib lib/${PLT}/*.{a,so*}
    exeinto ${T}/lib
    doexe lib/${PLT}/omnicpp
    dodir ${T}/lib/python
    cp -af lib/python/* ${D}/${T}/lib/python/
    doman man/man[15]/*.[15]

    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/omniORB

    dodoc CHANGES* COPYING* CREDITS PORTING README* ReleaseNote_omniORB_303 THIS_IS_omniORB_3_0_3
    cd doc
    docinto print
    dodoc *.ps
    dodoc *.tex
    dodoc *.pdf

    docinto html
    dodoc *.html
    docinto html/omniORB
    dodoc omniORB/*.{gif,html}

}
pkg_postinst() {
  if [ ! -f "${ROOT}etc/omniORB.cfg" ] ; then
    echo "ORBInitialHost `uname -n`" > ${ROOT}etc/omniORB.cfg
    echo "ORBInitialPort 8200" >> ${ROOT}etc/omniORB.cfg
  fi
}
