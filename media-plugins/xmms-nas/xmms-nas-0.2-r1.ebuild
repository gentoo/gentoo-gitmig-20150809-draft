# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nas/xmms-nas-0.2-r1.ebuild,v 1.15 2004/11/23 03:34:51 eradicator Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="A xmms plugin for NAS"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc -sparc x86"

DEPEND="media-sound/xmms
	media-libs/nas"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf --disable-static || die
	touch config.h
	make || die
}

src_install () {
	exeinto `xmms-config --input-plugin-dir`
	doexe .libs/libnas.so || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
