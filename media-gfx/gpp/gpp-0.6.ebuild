# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpp/gpp-0.6.ebuild,v 1.2 2004/01/21 22:05:41 leonardop Exp $

DESCRIPTION="GNOME Photo Printer"
HOMEPAGE="http://www.fogman.de/gpp/"
SRC_URI="http://www.fogman.de/${PN}/${P}.tgz"

IUSE=""
SLOT="0"
KEYWORDS="x86"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf || die

	emake || die
}

src_install() {
	einstall \
		gladedir=${D}/usr/share/gnome-photo-printer \
		pixmapsdir=${D}/usr/share/gnome-photo-printer || die

	dodoc AUTHORS ChangeLog COPYING COPYRIGHT NEWS README
}
