# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.9.6.ebuild,v 1.1 2004/02/18 10:32:16 liquidx Exp $

inherit gnome2

DESCRIPTION="A Gnome2 PHP/HTML source editor."
HOMEPAGE="http://www.gphpedit.org"
SRC_URI="http://gphpedit.org/download/files/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=x11-libs/gtkscintilla2-0.0.8
	=gnome-extra/libgtkhtml-2*"

DEPEND=">=dev-util/pkgconfig-0.12.0
		${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING README"
SCROLLKEEPER_UPDATE="0"
