# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-2.0.0.ebuild,v 1.2 2003/05/09 13:28:50 foser Exp $

inherit gnome2

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="A C++ code generating backend for glade"
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="virtual/glibc"

DOCS="AUTHORS BUGS COPYING ChangeLog NEWS README TODO docs/*"

pkg_postinst() {
	einfo "glademm generated sources have dependencies on packages not required by this ebuild."
}
