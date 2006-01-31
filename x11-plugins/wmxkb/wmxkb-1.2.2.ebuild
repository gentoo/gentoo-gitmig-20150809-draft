# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmxkb/wmxkb-1.2.2.ebuild,v 1.4 2006/01/31 21:11:35 nelchael Exp $

IUSE=""

DESCRIPTION="Dockable keyboard layout switcher for Window Maker"
HOMEPAGE="http://www.geocities.com/wmalms/#WMXKB"
SRC_URI="http://www.geocities.com/wmalms/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~sparc x86"

RDEPEND="|| ( (
		x11-libs/libX11
		x11-libs/libXt
		x11-libs/libXext
		x11-libs/libXpm )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( (
		x11-proto/xproto
		x11-proto/xextproto
		x11-proto/inputproto )
	virtual/x11 )"

src_install () {
	make DESTDIR=${D} BINDIR=${D}/usr/bin DOCDIR=${D}/usr/share/doc DATADIR=${D}/usr/share install
	dodoc README
	cd ${WORKDIR}/${P}/doc
	dodoc manual_body.html manual_title.html manual.book
}
