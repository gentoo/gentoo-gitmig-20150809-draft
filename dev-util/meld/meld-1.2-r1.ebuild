# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.2-r1.ebuild,v 1.1 2008/11/16 19:33:00 eva Exp $

inherit python gnome2 eutils multilib

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnome"

RDEPEND=">=dev-lang/python-2.3
	>=gnome-base/libglade-2
	>=gnome-base/libgnome-2
	>=dev-python/gnome-python-2.6.0
	>=dev-python/pygtk-2.6.0
	>=dev-python/pyorbit-1.99.0
	gnome? ( dev-python/gnome-python-desktop )"

DEPEND="${RDEPEND}
	dev-util/intltool
	app-text/scrollkeeper"

DOCS="AUTHORS changelog help/"

src_unpack() {
	gnome2_src_unpack

	# Fix installation bug for french help, mentioned in bug 230665
	epatch "${FILESDIR}/${P}-fr-help-install-fix.patch"

	# Fix word-wrapping option list, bug #246261
	epatch "${FILESDIR}/${P}-wrap-list.patch"

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
