# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/glademm/glademm-2.6.0.ebuild,v 1.2 2006/01/11 05:34:25 halcy0n Exp $

inherit eutils gnome2

DESCRIPTION="A C++ code generating backend for glade"
SRC_URI="http://home.wtal.de/petig/Gtk/${P}.tar.gz"
HOMEPAGE="http://home.wtal.de/petig/Gtk/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"

DEPEND="virtual/libc"

DOCS="AUTHORS BUGS COPYING ChangeLog NEWS README TODO docs/*"

src_unpack() {
	unpack ${A}

	epatch "${FILESDIR}"/${P}-gcc41.patch
}

pkg_postinst() {

	einfo "glademm generated sources have dependencies on packages not required by this ebuild."

}
