# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.1.4.ebuild,v 1.12 2007/02/03 21:38:27 kloeri Exp $

inherit python gnome2 eutils

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE="doc gnome"

DEPEND=">=dev-lang/python-2.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-2.6.0
	>=dev-python/pygtk-2.6.0
	>=dev-python/pyorbit-1.99.0
	gnome? ( dev-python/gnome-python-desktop )"

DOCS="AUTHORS README.CVS changelog help/"

src_unpack() {
	gnome2_src_unpack

	# Fix build with gettext-0.15, patch by Ed Catmur #143120
	epatch ${FILESDIR}/fix-po.patch

	# Fix the .desktop icon name
	sed -i -e "s:Icon=meld:Icon=/usr/share/pixmaps/meld.png:" ./meld.desktop.in

	# fix the prefix so its not in */local/*
	sed -i -e 's:/usr/local:/usr:' INSTALL

	# don't run scrollkeeper (with the wrong path), leave that to gnome2.eclass #145833
	sed -i -e '/scrollkeeper-update/s/\t/&#/' help/*/GNUmakefile
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
