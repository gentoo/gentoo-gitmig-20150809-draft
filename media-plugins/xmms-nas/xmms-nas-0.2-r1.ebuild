# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-nas/xmms-nas-0.2-r1.ebuild,v 1.8 2004/04/22 06:27:22 eradicator Exp $

IUSE=""

DESCRIPTION="A xmms plugin for NAS"
SRC_URI="ftp://mud.stack.nl/pub/OuterSpace/willem/${P}.tar.gz"
HOMEPAGE="http://www.xmms.org/plugins_input.html"

DEPEND="media-sound/xmms media-libs/nas"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"

src_compile() {
	econf || die
	touch config.h
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog NEWS README TODO
}
