# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-2.6.0.ebuild,v 1.1 2004/12/15 05:17:09 joem Exp $

inherit gnome2

DESCRIPTION="A C++ code generating backend for glade"
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="virtual/libc"

DOCS="AUTHORS BUGS COPYING ChangeLog NEWS README TODO docs/*"

pkg_postinst() {

	einfo "glademm generated sources have dependencies on packages not required by this ebuild."

}
