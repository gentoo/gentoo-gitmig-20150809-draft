# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aldumb/aldumb-0.9.2.ebuild,v 1.1 2003/07/20 04:49:33 jje Exp $

DESCRIPTION="Allegro support for DUMB. See the 'dumb' package's description for details."
SRC_URI="mirror://sourceforge/dumb/dumb-${PV}-fixed.tar.gz"
HOMEPAGE="http://dumb.sourceforge.net/"

LICENSE="DUMB-0.9.2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""
DEPEND="=media-libs/dumb-0.9.2-r1
	media-libs/allegro"

S=${WORKDIR}/dumb

src_unpack() {
	unpack ${A}
	cd ${S}
	patch Makefile < ${FILESDIR}/aldumb-0.9.2.Makefile.patch || die
}

src_compile() {
	echo 'include make/unix.inc' > make/config.txt || die
	echo 'ALL_TARGETS := allegro allegro-examples allegro-headers' >> make/config.txt || die
	echo 'PREFIX := /usr' >> make/config.txt || die
	emake OFLAGS="${CFLAGS}" all || die
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make install PREFIX=${D}/usr || die
}

