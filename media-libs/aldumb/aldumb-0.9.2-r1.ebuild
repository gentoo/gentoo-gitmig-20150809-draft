# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/aldumb/aldumb-0.9.2-r1.ebuild,v 1.7 2005/08/11 18:26:16 r3pek Exp $

inherit eutils

DESCRIPTION="Allegro support for DUMB (an IT, XM, S3M, and MOD player library)"
HOMEPAGE="http://dumb.sourceforge.net/"
SRC_URI="mirror://sourceforge/dumb/dumb-${PV}-fixed.tar.gz"

LICENSE="DUMB-0.9.2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc x86"
IUSE=""

DEPEND=">=media-libs/dumb-0.9.2-r2
	media-libs/allegro"

S=${WORKDIR}/dumb

src_unpack() {
	unpack ${A}
	cd "${S}"
	cat << EOF > make/config.txt
include make/unix.inc
ALL_TARGETS := allegro allegro-examples allegro-headers
PREFIX := /usr
EOF
	epatch "${FILESDIR}/${P}-PIC.patch"
}

src_compile() {
	emake OFLAGS="${CFLAGS}" all || die "emake failed"
}

src_install() {
	dodir /usr/lib /usr/include /usr/bin
	make PREFIX="${D}/usr" install || die "make install failed"
}
