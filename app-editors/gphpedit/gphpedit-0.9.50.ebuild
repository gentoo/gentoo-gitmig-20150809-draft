# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/gphpedit/gphpedit-0.9.50.ebuild,v 1.1 2004/11/15 20:59:30 liquidx Exp $

inherit gnome2

DESCRIPTION="A Gnome2 PHP/HTML source editor"
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://gphpedit.org/download/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.4
	>=gnome-base/libgnomeui-2.0
	=gnome-extra/libgtkhtml-2*"

DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

MAKEOPTS="${MAKEOPTS} -j1"
DOCS="AUTHORS ChangeLog README"
SCROLLKEEPER_UPDATE="0"
