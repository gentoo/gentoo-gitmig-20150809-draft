# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-wma/xmms-wma-1.0.3.ebuild,v 1.5 2004/07/17 10:19:06 dholm Exp $

IUSE=""

inherit eutils

DESCRIPTION="XMMS plugin to play wma"
HOMEPAGE="http://mcmcc.bat.ru/xmms-wma/"
SRC_URI="http://mcmcc.bat.ru/xmms-wma/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"

#~amd64: 1.0.3: Plays a little staticy, x86 is clear... both with 
#               media-video/ffmpeg-0.4.8.20040322-r1

KEYWORDS="~x86 ~amd64 ~ppc"

DEPEND="media-sound/xmms
	>=media-video/ffmpeg-0.4.8.20040322-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-ffmpeg.patch
}

src_compile () {
	emake || die
}

src_install () {
	exeinto `xmms-config --input-plugin-dir`
	doexe libwma.so
	dodoc readme.rus readme.eng
}
