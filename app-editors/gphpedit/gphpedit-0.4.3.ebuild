# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.4.3.ebuild,v 1.2 2003/09/05 23:05:05 msterret Exp $

inherit gnome2

DESCRIPTION="A Gnome2 PHP/HTML source editor."
HOMEPAGE="http://www.gphpedit.org"
SRC_URI="http://gphpedit.org/releases/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=x11-libs/gtkscintilla2-0.0.8"

DEPEND=">=dev-util/pkgconfig-0.12.0
		${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING README"
SCROLLKEEPER_UPDATE="0"
