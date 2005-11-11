# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.1.2.ebuild,v 1.1 2005/11/11 16:56:51 allanonjl Exp $

inherit python gnome2 eutils

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.2
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-1.99.15
	>=dev-python/pygtk-1.99.15
	>=dev-python/pyorbit-1.99.0
	dev-python/gnome-python-extras
	"

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix the .desktop icon name
	sed -i -e "s:Icon=meld:Icon=/usr/share/pixmaps/meld.png:" ./meld.desktop.in

	# fix omf scrollkeeper
	gnome2_omf_fix help/*/GNUmakefile

	# fix the prefix so its not in */local/*
	sed -i -e 's:/usr/local:/usr:' INSTALL
}

src_compile() {
	emake || die "make failed"
}

USE_DESTDIR="1"
DOCS="AUTHORS COPYING INSTALL README.CVS changelog help/"

pkg_postinst() {
	python_mod_optimize /usr/lib/meld
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/meld
}
