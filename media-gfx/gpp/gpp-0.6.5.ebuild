# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gpp/gpp-0.6.5.ebuild,v 1.3 2005/07/22 20:00:38 dholm Exp $

inherit gnome2

DESCRIPTION="GNOME Photo Printer"
HOMEPAGE="http://www.fogman.de/?GnomePhotoPrinter"
SRC_URI="http://www.fogman.de/${PN}/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
LICENSE="GPL-2"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	>=gnome-base/gnome-vfs-2"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.6"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog COPYRIGHT NEWS README"
