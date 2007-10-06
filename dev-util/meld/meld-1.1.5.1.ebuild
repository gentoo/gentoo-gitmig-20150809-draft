# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.1.5.1.ebuild,v 1.7 2007/10/06 09:04:13 tgall Exp $

inherit python gnome2 eutils

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86"
IUSE="doc gnome"

RDEPEND=">=dev-lang/python-2.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-2.6.0
	>=dev-python/pygtk-2.6.0
	>=dev-python/pyorbit-1.99.0
	gnome? ( dev-python/gnome-python-desktop )"

DEPEND="${RDEPEND}
	app-text/scrollkeeper"

DOCS="AUTHORS README.CVS changelog help/"

src_unpack() {
	gnome2_src_unpack

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
