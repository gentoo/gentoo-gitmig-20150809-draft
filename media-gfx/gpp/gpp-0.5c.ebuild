# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpp/gpp-0.5c.ebuild,v 1.3 2004/01/21 22:05:41 leonardop Exp $

# No real need to inherit from gnome2 eclass (yet)
#inherit gnome2

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
	>=gnome-base/libgnomeprintui-2.2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# no ./configure script..

	emake || die "Compilation failure"
}

src_install() {
	make gpp

	# Manually install everything, since the Makefile has its problems
	exeinto /usr/bin
	doexe gnome-photo-printer

	insinto /usr/share/gnome-photo-printer
	doins gpp.glade skale_with_ratio.jpg skale_without_ratio.jpg

	dodoc AUTHORS ChangeLog COPYING COPYRIGHT NEWS README
}
