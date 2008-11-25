# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdsp/libdsp-5.0.2.ebuild,v 1.2 2008/11/25 15:19:29 armin76 Exp $

inherit eutils

DESCRIPTION="C++ class library of common digital signal processing functions."
HOMEPAGE="http://libdsp.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${PN}-src-${PV}.tar.gz
		doc? ( mirror://sourceforge/${PN}/${PN}-doc-html.tar.gz )"

LICENSE="GPL-2"
SLOT="0"

# -amd64, -sparc: 4.9.2-r1 - uses x86 assembly
KEYWORDS="-amd64 -sparc x86"
IUSE="doc"
DEPEND=""

S=${WORKDIR}/${PN}-src-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# fixes some Makefile weirdness
	epatch "${FILESDIR}"/${P}-Makefile.patch
}

src_compile() {
	# use our CFLAGS/CXXFLAGS instead
	sed -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" -i libDSP/Makefile
	sed -e "s:^CXXFLAGS.*:CXXFLAGS = ${CXXFLAGS}:" -i DynThreads/Makefile

	# use our PREFIX too
	sed -e "s:^PREFIX.*:PREFIX = ${D}/usr:" -i Inlines/Makefile
	sed -e "s:^PREFIX.*:PREFIX = ${D}/usr:" -i libDSP/Makefile
	sed -e "s:^PREFIX.*:PREFIX = ${D}/usr:" -i DynThreads/Makefile

	# fix NPTL includes
	for filename in $(grep -rl nptl/pthread *); do
		sed -e "s:nptl/pthread.h:pthread.h:g" -i $filename
	done

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

	mkdir -p ${D}/usr/include
	cd ${S}/Inlines
	make install || die "Inlines install failed!"

	cd ${S}/DynThreads
	make install || die "DynThreads install failed!"

	cd ${S}/libDSP
	make install || die "libDSP install failed!"

	if use doc; then
		dohtml ${WORKDIR}/${PN}-doc-html/*
		docinto samples
		dodoc ${S}/libDSP/work/*
	fi
}
