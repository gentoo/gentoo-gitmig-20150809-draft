# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libmusepack/libmusepack-1.0.2.ebuild,v 1.2 2004/09/22 10:31:54 eradicator Exp $

IUSE=""

inherit eutils

DESCRIPTION="Musepack decoder library"
HOMEPAGE="http://www.musepack.net"
SRC_URI="http://www.musepack.net/downloads/source/${S}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND="virtual/libc"

DEPEND="${RDEPEND}
	app-arch/unzip"

src_unpack () {
	mkdir ${S}
	cd ${S}
	unpack ${A}

	sed -i -e 's:-O2 -march=i686 -pipe:$(CFLAGS):' \
	       -e 's:libmusepack.so.1.0.1:libmusepack.so.1.0.2:' Makefile
}

src_compile() {
	emake || die "make failed"
}


src_install() {
	insinto /usr/include/musepack
	doins *.h
	dolib.so libmusepack.so.${PV}
	dosym libmusepack.so.${PV} /usr/$(get_libdir)/libmusepack.so.1
	dosym libmusepack.so.${PV} /usr/$(get_libdir)/libmusepack.so
}
