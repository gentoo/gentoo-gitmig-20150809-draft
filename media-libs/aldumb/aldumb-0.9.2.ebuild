# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aldumb/aldumb-0.9.2.ebuild,v 1.2 2003/10/28 19:58:02 vapier Exp $

DESCRIPTION="Allegro support for DUMB (an IT, XM, S3M, and MOD player library)"
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/dumb-${PV}-fixed.tar.gz"

LICENSE="DUMB-0.9.2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=media-libs/dumb-0.9.2-r1
	media-libs/allegro"

S=${WORKDIR}/dumb

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.Makefile.patch
	cat << EOF > make/config.txt
include make/unix.inc
ALL_TARGETS := allegro allegro-examples allegro-headers
PREFIX := /usr
EOF
}

src_compile() {
	emake OFLAGS="${CFLAGS}" all || die
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make install PREFIX=${D}/usr || die
}
