# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmenu/wmmenu-1.2.ebuild,v 1.2 2005/01/24 16:45:49 s4t4n Exp $

inherit eutils

IUSE="gnome"
S=${WORKDIR}/${PN}
DESCRIPTION="WindowMaker DockApp: Provides a popup menu of icons like in AfterStep, as a dockable application."
SRC_URI="http://www.fcoutant.freesurf.fr/download/${P}.tar.gz"
HOMEPAGE="http://www.fcoutant.freesurf.fr/wmmenu.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
DEPEND="virtual/x11
	>=x11-libs/libdockapp-0.5.0-r1
	gnome? ( media-libs/gdk-pixbuf )"

src_unpack()
{
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-support-libdockapp-0.5.0.patch
	epatch ${FILESDIR}/${P}-Makefile.patch
}

src_compile()
{
	GDKPIXBUF=""
	if use gnome; then
		GDKPIXBUF="GDKPIXBUF=1"
	fi

	emake ${GDKPIXBUF} EXTRACFLAGS="${CFLAGS}" || die "Compilation failed"
}

src_install ()
{
	dobin wmmenu
	doman wmmenu.1
	dodoc COPYING README TODO example/apps example/defaults example/extract_icon_back
}
