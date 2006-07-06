# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.1.3.ebuild,v 1.3 2006/07/06 04:22:37 tsunam Exp $

inherit python gnome2 eutils

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND=">=dev-lang/python-2.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-2.6.0
	>=dev-python/pygtk-2.6.0
	>=dev-python/pyorbit-1.99.0
	dev-python/gnome-python-extras"

DOCS="AUTHORS COPYING INSTALL README.CVS changelog help/"

pkg_setup() {
	if has_version "=dev-python/pygtk-2.6*"; then
		if ! built_with_use "dev-python/pygtk" gnome ; then
			einfo
			einfo "Meld requires pygtk to be built with the gnome use flag set."
			einfo "Please re-emerge pygtk with the gnome use flag set."
			einfo
			die "You need to re-emerge pygtk with gnome use flag."
		fi
	fi
}

src_unpack() {
	gnome2_src_unpack

	# Fix the .desktop icon name
	sed -i -e "s:Icon=meld:Icon=/usr/share/pixmaps/meld.png:" ./meld.desktop.in

	# fix the prefix so its not in */local/*
	sed -i -e 's:/usr/local:/usr:' INSTALL
}

src_compile() {
	emake || die "make failed"
}

pkg_postinst() {
	python_mod_optimize /usr/lib/meld
}

pkg_postrm() {
	python_mod_cleanup /usr/lib/meld
}
