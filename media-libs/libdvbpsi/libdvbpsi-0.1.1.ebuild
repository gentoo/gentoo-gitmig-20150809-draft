# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.1.ebuild,v 1.3 2002/08/15 17:09:05 gerk Exp $

DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://www.videolan.org/pub/videolan/libdvbpsi/0.1.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -sparc -sparc64"

DEPEND=">=app-doc/doxygen-1.2.16"
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {

	econf \
		--enable-release || die "econf failed"

	emake || die "emake failed"

	make doc || die "make doc failed"

}

src_install () {

	einstall || die "einstall failed"

	dohtml ${S}/doc/doxygen/html/*

	cd ${S}
	dodoc AUTHORS INSTALL README NEWS

}
