# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audio-entropyd/audio-entropyd-0.0.6.ebuild,v 1.1 2004/03/31 09:58:00 method Exp $

DESCRIPTION="Audio-entropyd generates entropy-data for the /dev/random device."
HOMEPAGE="http://www.vanheusden.com/aed/"
SRC_URI="http://www.vanheusden.com/aed/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin audio-entropyd
	exeinto /etc/init.d
	newexe ${FILESDIR}/audio-entropyd.init audio-entropyd
}
