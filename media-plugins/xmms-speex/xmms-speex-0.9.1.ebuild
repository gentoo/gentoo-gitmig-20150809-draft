# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-speex/xmms-speex-0.9.1.ebuild,v 1.1 2005/11/12 19:32:16 metalgod Exp $

inherit eutils

IUSE=""

MY_P=speex-xmms-${PV}
S=${WORKDIR}/speex-xmms
DESCRIPTION="Speex plugin for XMMS"
HOMEPAGE="http://jzb.rapanden.dk/projects/speex-xmms"
SRC_URI="http://jzb.rapanden.dk/pub/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-sound/xmms"
DEPEND="${RDEPEND}
		>=media-libs/libogg-1.1
		<=media-libs/speex-1.1.5
		>=x11-libs/gtk+-1.2.10-r11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}.patch
	epatch ${FILESDIR}/${P}-Makefile.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_install() {
	exeinto `xmms-config --input-plugin-dir`
	doexe libspeex.so || die
	dodoc COPYING README
}
