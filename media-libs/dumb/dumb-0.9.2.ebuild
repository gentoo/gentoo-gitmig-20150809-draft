# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/dumb/dumb-0.9.2.ebuild,v 1.1 2003/06/06 21:16:43 robh Exp $

DESCRIPTION="IT/XM/S3M/MOD player library with click removal and IT filters"
SRC_URI="mirror://sourceforge/dumb/${P}-fixed.tar.gz"
HOMEPAGE="http://dumb.sourceforge.net/"

LICENSE="DUMB-0.9.2"
SLOT="0"
KEYWORDS="~x86"

IUSE="dumb-allegro"
DEPEND="dumb-allegro? ( media-libs/allegro )"

S=${WORKDIR}/${PN}

src_compile() {
	echo 'include make/unix.inc' > make/config.txt
	echo 'ALL_TARGETS := core core-examples core-headers' >> make/config.txt
	if [ "`use dumb-allegro`" ]; then echo 'ALL_TARGETS += allegro allegro-examples allegro-headers' >> make/config.txt; fi
	echo 'PREFIX := /usr' >> make/config.txt
	emake OFLAGS="${CFLAGS}" all || die
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make install PREFIX=${D}/usr || die

	dodoc readme.txt release.txt docs/*
}
