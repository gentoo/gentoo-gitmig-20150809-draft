# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glabels/glabels-1.90.0.ebuild,v 1.3 2003/06/29 23:17:15 aliz Exp $

DESCRIPTION="Program for creating labels and business cards"
HOMEPAGE="http://snaught.com/glabels/"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""
SRC_URI="http://snaught.com/${PN}/source/${P}.tar.gz"

DEPEND=">=x11-libs/gtk+-2.0.5
    >=dev-libs/libxml2-2.4.23
    >=gnome-base/libgnomeprint-1.115
    >=gnome-base/libgnomeprintui-1.115
    >=gnome-base/libgnomecanvas-2.0.1
	>=gnome-base/libgnomeui-2.0.1
	>=gnome-base/libbonobo-2
    media-libs/gdk-pixbuf
	>=dev-util/pkgconfig-0.8
	>=dev-util/intltool-0.21"

S=${WORKDIR}/${P}

src_compile() {
	econf --enable-platform-gnome-2 || die "./configure failed"

	emake || die "Compilation failed"
}
src_install() {
    einstall || die "Installation failed"

	# Put the .desktop file in a more reasonable place
	mv \
		${D}/usr/share/gnome/apps/Applications \
		${D}/usr/share/gnome/apps/Utilities

	dodoc AUTHORS COPYING README TODO
}
