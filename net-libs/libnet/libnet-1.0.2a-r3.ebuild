# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a-r3.ebuild,v 1.8 2003/12/17 00:40:44 vapier Exp $

inherit eutils

DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/libnet/dist/${PN}.tar.gz"

LICENSE="LGPL-2"
SLOT="1.0"
KEYWORDS="x86 ppc sparc arm alpha amd64"

S=${WORKDIR}/Libnet-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libnet-gcc33-fix
	epatch ${FILESDIR}/${PV}-slot.patch
	cd ${S}
	mv libnet-config.in libnet-${SLOT}-config.in || die "moving libnet-config"
	cd ${S}/include
	ln -s libnet.h libnet-${SLOT}.h
	cd libnet
	for f in *.h ; do
		ln -s ${f} ${f/-/-${SLOT}-} || die "linking ${f}"
	done
	cd ${S}/doc
	ln -s libnet.3 libnet-${SLOT}.3 || die "linking manpage"
	cd ${S}
	autoconf || die
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die "Failed to compile"
}

src_install() {
	make install DESTDIR=${D} || die

	dodoc VERSION doc/{README,TODO*,CHANGELOG*,COPYING}
	newdoc README README.1st
	docinto example ; dodoc example/libnet*
	docinto Ancillary ; dodoc doc/Ancillary/*
}

pkg_postinst(){
	einfo "libnet ${SLOT} is deprecated !"
	einfo "config script: libnet-${SLOT}-config"
	einfo "manpage: libnet-${SLOT}"
	einfo "library: libnet-${SLOT}.a"
	einfo "include: libnet-${SLOT}.h"
}
