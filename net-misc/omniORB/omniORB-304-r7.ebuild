# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/omniORB/omniORB-304-r7.ebuild,v 1.12 2004/07/15 03:15:34 agriffis Exp $

inherit eutils

S=${WORKDIR}/${PN/ORB/}
DESCRIPTION="a robust, high-performance CORBA 2 ORB"
HOMEPAGE="http://www.uk.research.att.com/omniORB/"
SRC_URI="ftp://ftp.uk.research.att.com/pub/omniORB/omniORB3/${PN}_${PV}.tar.gz
	 ftp://ftp.uk.research.att.com/pub/omniORB/omniORBpy/${PN}py_1_4.tar.gz
	 ftp://ftp.uk.research.att.com/pub/omniNotify/omniNotify1/omniNotify11b1.tar.gz
	 ftp://ftp.uk.research.att.com/pub/omniORB/omniORB3/${PN}_${PV}_bugfixes.patch"

DEPEND="dev-lang/python"

PLT="i586_linux_2.0_glibc2.1"
KEYWORDS="x86 sparc "
IUSE=""
SLOT="0"
LICENSE="LGPL-2 GPL-2"

src_unpack() {

	unpack ${PN}_${PV}.tar.gz
	cd ${S}
	epatch  ${DISTDIR}/${PN}_${PV}_bugfixes.patch
	cd ${S}/src/lib
	unpack ${PN}py_1_4.tar.gz
	cd ${S}/src/services
	unpack omniNotify11b1.tar.gz

	cd ${S}/config
	cp config.mk config.mk.orig
	sed -e "s:#platform = ${PLT}:platform = ${PLT}:" \
		config.mk.orig > config.mk



	cd ${S}/mk
	cp unix.mk unix.mk.orig
	sed -e "s:^MKDIRHIER.*:MKDIRHIER = mkdir -p:" \
		unix.mk.orig > unix.mk

	cd platforms
	cp ${PLT}.mk ${PLT}.orig
	sed -e "s:#PYTHON = /usr.*:PYTHON=/usr/bin/python:" \
		${PLT}.orig > ${PLT}.mk

}


src_compile() {
	cd ${S}/src
	make export || die

	cd ${S}/src/lib/omniORBpy
	make export || die

	cd ${S}/src/services/omniNotify
	make export || die
}

src_install () {

	dodir /usr/share/omniORB/bin/scripts
	cp -af bin/scripts/* ${D}/usr/share/omniORB/bin/scripts
	dobin bin/${PLT}/*

	insinto /usr/idl
	doins idl/*.idl

	insinto /usr/idl/COS
	doins idl/COS/*.idl

	cp -af include ${D}/usr

	# change from python2.1 to python2.2
	dodir /usr/lib/python2.2/site-packages

	cp -af	lib/${PLT}/_* ${D}/usr/lib/python2.2/site-packages
	dolib lib/${PLT}/*.{a,so*}
	rm ${D}/usr/lib/_*.*

	exeinto /usr/lib/python2.2/site-packages
	doexe lib/${PLT}/omnicpp
	cp -af lib/python/* ${D}/usr/lib/python2.2/
	doman man/man[15]/*.[15]

	exeinto /etc/init.d
	newexe ${FILESDIR}/omniORB.rc6 omniORB
	dodir /etc/omniorb
	insinto /etc/omniorb
	cd ${S}
	doins src/services/omniNotify/channel.cfg
	doins src/services/omniNotify/standard.cfg

	dodoc CHANGES* COPYING* CREDITS PORTING README* ReleaseNote_omniORB_304 \
		THIS_IS_omniORB_3_0_4

	cd doc
	docinto print
	dodoc *.ps
	dodoc *.tex
	dodoc *.pdf

	dodoc -r .

	dodir /etc/env.d/
	echo "PATH=/usr/share/omniORB/bin/scripts" > ${D}/etc/env.d/90omniORB
	echo "OMNIORB_CONFIG=/etc/omniorb/omniORB.cfg" >> ${D}/etc/env.d/90omniORB
}
pkg_postinst() {
	if [ ! -f "${ROOT}etc/omniorb/omniORB.cfg" ] ; then
		echo "ORBInitialHost `uname -n`" > ${ROOT}etc/omniorb/omniORB.cfg
		echo "ORBInitialPort 2809" >> ${ROOT}etc/omniorb/omniORB.cfg
	fi
	/usr/bin/python ${FILESDIR}/mkomnistubs.py
}
