# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmenu/wmmenu-1.2-r1.ebuild,v 1.5 2006/01/15 17:57:41 nelchael Exp $

inherit eutils

IUSE="gnome"
S=${WORKDIR}/${PN}
DESCRIPTION="WindowMaker DockApp: Provides a popup menu of icons like in AfterStep, as a dockable application."
SRC_URI="http://www.fcoutant.freesurf.fr/download/${P}.tar.gz"
HOMEPAGE="http://www.fcoutant.freesurf.fr/wmmenu.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 x86"
DEPEND="x11-libs/libdockapp
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
	dodoc README TODO example/apps example/defaults example/extract_icon_back
}
