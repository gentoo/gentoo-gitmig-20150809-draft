# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.0.2.ebuild,v 1.1 2004/09/22 10:07:25 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.musepack.net/downloads/source/${S}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

src_unpack () {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	sed -i 's:-O2 -march=i686 -pipe:${CFLAGS}:g' Makefile
	sed -i {s/libmusepack.so.1.0.1/libmusepack.so.1.0.2/} Makefile
}

src_compile() {
	emake || die "make failed"
}


src_install() {
	dodir /usr/include/musepack
	insinto /usr/include/musepack
	doins *.h
	dolib.so libmusepack.so.${PV}
	dosym libmusepack.so.${PV} /usr/$(get_libdir)/libmusepack.so.1
	dosym libmusepack.so.${PV} /usr/$(get_libdir)/libmusepack.so
}
