# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/berlin-base/omniORB/omniORB-303.ebuild,v 1.3 2001/05/02 18:59:33 achim Exp $

A=${PN}_${PV}.tar.gz
S=${WORKDIR}/omni
DESCRIPTION="a robust, high-performance CORBA 2 ORB"
SRC_URI="ftp://ftp.uk.research.att.com/pub/omniORB/omniORB3/${A}"
HOMEPAGE="http://www.uk.research.att.com/omniORB/"

DEPEND=""

PLT="i586_linux_2.0_glibc2.1"

src_unpack() {

  unpack ${A}

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

}

src_install () {

    T=/opt/berlin
    into ${T}
    cd ${S}
    dobin bin/${PLT}/*
    insinto ${T}/lib/idl
    doins idl/*.idl
    insinto ${T}/lib/idl/COS
    doins idl/COS/*.idl
    cp -af include ${D}/${T}
    dolib lib/${PLT}/*.{a,so*}
    exeinto ${T}/lib
    doexe lib/${PLT}/omnicpp
    dodir /usr/lib/python2.0
    cp -af lib/python/* ${D}/usr/lib/python2.0/
    doman man/man[15]/*.[15]

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

