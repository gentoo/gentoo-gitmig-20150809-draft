# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nas/xmms-nas-0.2-r1.ebuild,v 1.12 2004/09/14 07:07:32 eradicator Exp $

IUSE=""

inherit gnuconfig

DESCRIPTION="A xmms plugin for NAS"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND="media-sound/xmms media-libs/nas"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc amd64"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update
}

src_compile() {
	econf || die
	touch config.h
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
