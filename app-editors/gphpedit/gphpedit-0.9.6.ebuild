# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.9.6.ebuild,v 1.6 2005/03/27 00:44:58 hansmi Exp $

inherit gnome2

DESCRIPTION="A Gnome2 PHP/HTML source editor"
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://gphpedit.org/download/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.0
	>=gnome-base/libgnomeui-2.0
	>=x11-libs/gtkscintilla2-0.1.0
	=gnome-extra/libgtkhtml-2*"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog README"
SCROLLKEEPER_UPDATE="0"
