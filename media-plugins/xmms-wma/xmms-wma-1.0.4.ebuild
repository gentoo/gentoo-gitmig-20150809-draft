# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-wma/xmms-wma-1.0.4.ebuild,v 1.1 2005/03/21 02:57:38 eradicator Exp $

IUSE=""

inherit eutils toolchain-funcs

DESCRIPTION="XMMS plugin to play wma"
HOMEPAGE="http://mcmcc.bat.ru/xmms-wma/"
SRC_URI="http://mcmcc.bat.ru/xmms-wma/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"

#~sparc: 1.0.4: Plays a little staticy, x86/adm64 is clear...

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="media-sound/xmms
	>=media-video/ffmpeg-0.4.9_p20050226-r1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-ffmpeg.patch
}

src_compile () {
	emake CC="$(tc-getCC)" || die
}

src_install () {
	exeinto `xmms-config --input-plugin-dir`
	doexe libwma.so
	dodoc readme.rus readme.eng
}
