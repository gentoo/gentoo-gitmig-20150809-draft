# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-2.0.0.1.ebuild,v 1.2 2003/12/12 15:46:22 aliz Exp $

inherit gnome2


DESCRIPTION="A C++ code generating backend for glade"
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="virtual/glibc"

DOCS="AUTHORS BUGS COPYING ChangeLog NEWS README TODO docs/*"

src_unpack() {
	unpack ${A}

	# Patch that fixes a missing <cassert> include in the source
	# Closes Bug #29654
	#epatch ${FILESDIR}/${P}-gcc33-missing-includes-fix.patch
}

pkg_postinst() {
	einfo "glademm generated sources have dependencies on packages not required by this ebuild."
}
