# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audio-entropyd/audio-entropyd-0.0.6.ebuild,v 1.2 2004/03/31 10:14:35 method Exp $

DESCRIPTION="Audio-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/aed/"
SRC_URI="http://www.vanheusden.com/aed/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
RDEPEND="${DEPEND}
		>=sys-apps/sed-4"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i.orig \
		-e "s:^OPT_FLAGS=.*:OPT_FLAGS=$CFLAGS:" \
		Makefile
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dosbin audio-entropyd

	insinto /etc/init.d
	insopts -m0755
	newins ${FILESDIR}/${PN}.init ${PN}
}
