# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdsp/libdsp-4.9.2.ebuild,v 1.3 2005/07/13 14:25:11 swegener Exp $

inherit eutils

DESCRIPTION="C++ class library of common digital signal processing functions."
HOMEPAGE="http://libdsp.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.gz
		doc? ( mirror://sourceforge/${PN}/${PN}-doc-html.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"
KEYWORDS="~x86"
DEPEND=""

S=${WORKDIR}/${PN}-src-${PV}

src_compile() {
	# fixes some Makefile weirdness
	epatch ${FILESDIR}/Makefile.patch

	# use our CFLAGS/CXXFLAGS instead
	sed -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" -i libDSP/Makefile
	sed -e "s:^CXXFLAGS.*:CXXFLAGS = ${CXXFLAGS}:" -i DynThreads/Makefile

	# use our PREFIX too
	sed -e "s:^PREFIX.*:PREFIX = ${D}/usr:" -i libDSP/Makefile
	sed -e "s:^PREFIX.*:PREFIX = ${D}/usr:" -i DynThreads/Makefile

	# libtool only supports the --tag option from v1.5 onwards
	if ! has_version ">=sys-devel/libtool-1.5.0"; then
		sed -e "s/^LIBTOOL = libtool --tag=CXX/LIBTOOL = libtool/" -i libDSP/Makefile
	fi

	cd ${S}/DynThreads
	emake || die "DynThreads make failed!"

	cd ${S}/libDSP
	emake || die "libDSP make failed!"
}

src_install() {

	cd ${S}/DynThreads
	make install || die "DynThreads install failed!"

	cd ${S}/libDSP
	make install || die "libDSP install failed!"

	if use doc; then
		dohtml ${WORKDIR}/${PN}-doc-html/*
	fi
}
