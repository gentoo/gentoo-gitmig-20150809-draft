# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audiocompress/audiocompress-1.5.1.ebuild,v 1.2 2004/08/04 03:31:24 dholm Exp $

IUSE="xmms"

inherit eutils

MY_P="AudioCompress-${PV}"

DESCRIPTION="AudioCompress is (essentially) a very gentle, 1-band dynamic range compressor intended to keep audio output at a consistent volume without introducing any audible artifacts."
HOMEPAGE="http://trikuare.cx/code/AudioCompress.html"
SRC_URI="http://trikuare.cx/code/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
#-amd64: 1.5.1 - Floating point exception when using xmms plugin
KEYWORDS="~x86 -amd64 ~ppc"

DEPEND="xmms? ( media-sound/xmms )"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd ${S}
	make clean

	epatch ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	if use xmms; then
		emake || die
	else
		emake AudioCompress || die
	fi
}

src_install() {
	dobin AudioCompress || die
	if use xmms; then
		exeinto "$(xmms-config --effect-plugin-dir)" || die
		doexe libcompress.so || die
	fi
	dodoc COPYING ChangeLog README TODO
}
