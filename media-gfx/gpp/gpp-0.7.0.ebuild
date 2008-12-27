# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpp/gpp-0.7.0.ebuild,v 1.2 2008/12/27 12:55:39 eva Exp $

inherit autotools eutils gnome2

DESCRIPTION="GNOME Photo Printer"
HOMEPAGE="http://www.fogman.de/?GnomePhotoPrinter"
SRC_URI="http://www.fogman.de/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/gnome-vfs-2
	>=dev-libs/glib-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.16
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYRIGHT ChangeLog README"

src_unpack() {
	gnome2_src_unpack

	mkdir "m4"

	# Fix compilation with as-needed, bug #247729
	epatch "${FILESDIR}/${P}-as-needed.patch"

	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
