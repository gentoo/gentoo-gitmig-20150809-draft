# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.3.0.ebuild,v 1.2 2009/04/27 20:01:39 eva Exp $

inherit python gnome2 eutils multilib

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc gnome"

RDEPEND=">=dev-lang/python-2.4
	>=gnome-base/libglade-2
	gnome? (
		>=gnome-base/libgnome-2
		>=dev-python/libgnome-python-2.22
		>=dev-python/gconf-python-2.22
		>=dev-python/gnome-vfs-python-2.22 )
	>=dev-python/pygtk-2.8.0
	>=dev-python/pygobject-2.8"

DEPEND="${RDEPEND}
	dev-util/intltool
	app-text/scrollkeeper"

DOCS="AUTHORS changelog help/"

src_unpack() {
	gnome2_src_unpack

	# fix the prefix so its not in */local/*
	sed -e 's:/usr/local:/usr:' \
		-e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):" \
		-i INSTALL || die "sed 1 failed"

	# don't install anything to /usr/share/doc/meld
	sed -e "s:\$(docdir)/meld:\$(docdir)/${PF}:" \
		-i INSTALL || die "sed 2 failed"

	# let the python eclass handle python objects
	sed -e '/$(PYTHON) .* .import compileall;/s/\t/&#/g' \
		-i GNUmakefile || die "sed 3 failed"

	# don't run scrollkeeper (with the wrong path), leave that to gnome2.eclass #145833
	sed -e '/scrollkeeper-update/s/\t/&#/' \
		-i help/*/GNUmakefile || die "sed 4 failed"

	strip-linguas -i "${S}/po"
	local mylinguas=""
	for x in ${LINGUAS}; do
		mylinguas="${mylinguas} ${x}.po"
	done

	if [ -n "${mylinguas}" ]; then
		sed -e "s/PO:=.*/PO:=${mylinguas}/" \
			-i po/GNUmakefile || die "sed 5 failed"
	fi
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
