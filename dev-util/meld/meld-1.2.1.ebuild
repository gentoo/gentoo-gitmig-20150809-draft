# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.2.1.ebuild,v 1.3 2009/02/07 12:07:50 armin76 Exp $

inherit python gnome2 eutils multilib

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnome"

RDEPEND=">=dev-lang/python-2.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gconf-python-2.22
	>=dev-python/libgnome-python-2.22
	>=dev-python/gnome-vfs-python-2.22
	>=dev-python/pygtk-2.8.0
	>=dev-python/pyorbit-1.99.0
	gnome? ( dev-python/gnome-python-desktop )"

DEPEND="${RDEPEND}
	dev-util/intltool
	app-text/scrollkeeper"

DOCS="AUTHORS changelog help/"

src_unpack() {
	gnome2_src_unpack

	# fix the prefix so its not in */local/*
	sed -i -e 's:/usr/local:/usr:' INSTALL
	sed -i -e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):" INSTALL

	# don't install anything to /usr/share/doc/meld
	sed -i -e "s:\$(docdir)/meld:\$(docdir)/${PF}:" INSTALL

	# let the python eclass handle python objects
	sed -i -e '/$(PYTHON) .* .import compileall;/s/\t/&#/g' GNUmakefile

	# don't run scrollkeeper (with the wrong path), leave that to gnome2.eclass #145833
	sed -i -e '/scrollkeeper-update/s/\t/&#/' help/*/GNUmakefile

	strip-linguas -i "${S}/po"
	local mylinguas=""
	for x in ${LINGUAS}; do
		mylinguas="${mylinguas} ${x}.po"
	done

	sed -i -e "s/PO:=.*/PO:=${mylinguas}/" po/GNUmakefile
}

src_compile() {
	emake || die "make failed"
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/meld
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/meld
}
