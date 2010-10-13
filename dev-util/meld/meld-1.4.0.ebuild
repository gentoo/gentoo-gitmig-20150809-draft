# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/meld/meld-1.4.0.ebuild,v 1.3 2010/10/13 20:35:34 eva Exp $

EAPI="3"
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.4"

inherit python gnome2 eutils multilib

DESCRIPTION="A graphical (GNOME 2) diff and merge tool"
HOMEPAGE="http://meld.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="doc gnome"

RDEPEND="
	>=gnome-base/libglade-2
	>=dev-python/pygtk-2.8
	>=dev-python/pygobject-2.8
	gnome? (
		>=gnome-base/libgnome-2
		>=dev-python/libgnome-python-2.22
		>=dev-python/gconf-python-2.22
		>=dev-python/gnome-vfs-python-2.22 )
"
DEPEND="${RDEPEND}
	dev-util/intltool
	app-text/scrollkeeper"

DOCS="AUTHORS NEWS help/ChangeLog"

src_prepare() {
	gnome2_src_prepare

	# fix the prefix so its not in */local/*
	sed -e "s:/usr/local:${EPREFIX}/usr:" \
		-e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):" \
		-i INSTALL || die "sed 1 failed"

	# don't install anything to /usr/share/doc/meld
	sed -e "s:\$(docdir)/meld:\$(docdir)/${PF}:" \
		-i INSTALL || die "sed 2 failed"

	# let the python eclass handle python objects
	sed -e '/$(PYTHON) .* .import compileall;/s/\t/&#/g' \
		-i Makefile || die "sed 3 failed"

	# don't run scrollkeeper (with the wrong path),
	# leave that to gnome2.eclass #145833
	sed -e '/scrollkeeper-update/s/\t/&#/' \
		-i help/*/Makefile || die "sed 4 failed"

	# fix test suite
	sed -e 's,\(for file in \["\)\(meld"\]\),\1bin/\2,' \
		-e 's,\(open("\)\(meldapp.py")\),\1meld/\2,' \
		-i tools/check_release || die "sed 5 failed"

	# replace all calls to python by specific major version
	sed -e "s/\(PYTHON ?= \).*/\1$(PYTHON -2)/" \
		-i INSTALL || die "sed 6 failed"
	python_convert_shebangs 2 "${S}"/tools/*

	strip-linguas -i "${S}/po"
	local mylinguas=""
	for x in ${LINGUAS}; do
		mylinguas="${mylinguas} ${x}.po"
	done

	if [ -n "${mylinguas}" ]; then
		sed -e "s/PO:=.*/PO:=${mylinguas}/" \
			-i po/Makefile || die "sed 5 failed"
	fi
}

src_configure() {
	:
}

src_install() {
	gnome2_src_install
	python_convert_shebangs 2 "${ED}"usr/bin/meld
}

pkg_postinst() {
	gnome2_pkg_postinst
	PYTHON_ABI=$(PYTHON -2 --ABI)
	python_mod_optimize /usr/$(get_libdir)/meld
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_mod_cleanup /usr/$(get_libdir)/meld
}
