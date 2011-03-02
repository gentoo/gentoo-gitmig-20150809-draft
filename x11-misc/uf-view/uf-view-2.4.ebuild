# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/uf-view/uf-view-2.4.ebuild,v 1.8 2011/03/02 19:04:13 signals Exp $

EAPI=1

inherit gnome2

DESCRIPTION="UF-View is a Gnome viewer for the UserFriendly comic"
HOMEPAGE="http://www.hadess.net/misc-code.php3"
SRC_URI="http://www.hadess.net/files/software/uf-view/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ppc"
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/gtk+:2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=gnome-base/gnome-desktop-2:2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog README NEWS THANKS"
