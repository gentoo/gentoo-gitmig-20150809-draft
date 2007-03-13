# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpp/gpp-0.7.0.ebuild,v 1.1 2007/03/13 22:36:02 leonardop Exp $

inherit gnome2

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
	>=dev-util/pkgconfig-0.6
	>=dev-util/intltool-0.35"

DOCS="AUTHORS COPYRIGHT ChangeLog README"
