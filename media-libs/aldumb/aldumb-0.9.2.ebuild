# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aldumb/aldumb-0.9.2.ebuild,v 1.5 2004/03/19 17:48:51 agriffis Exp $

inherit eutils

S="${WORKDIR}/dumb"
DESCRIPTION="Allegro support for DUMB (an IT, XM, S3M, and MOD player library)"
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/dumb-${PV}-fixed.tar.gz"

KEYWORDS="x86 ~ppc ~alpha ~ia64"
LICENSE="DUMB-0.9.2"
SLOT="0"

DEPEND="=media-libs/dumb-0.9.2-r1
	media-libs/allegro"

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
	emake OFLAGS="${CFLAGS}" all || die "emake failed"
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make PREFIX=${D}/usr install || die "make install failed"
}
