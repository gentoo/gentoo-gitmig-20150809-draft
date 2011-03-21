# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gconfmm/gconfmm-2.28.2-r1.ebuild,v 1.1 2011/03/21 01:29:30 nirbheek Exp $

EAPI="2"

inherit autotools gnome2 eutils

DESCRIPTION="C++ bindings for GConf"
HOMEPAGE="http://www.gtkmm.org"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="doc examples"

RDEPEND=">=gnome-base/gconf-2.4:2
	>=dev-cpp/glibmm-2.12:2
	>=dev-cpp/gtkmm-2.4:2.4"

DEPEND=">=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-cpp/mm-common-0.9.3 )
	${RDEPEND}"

DOCS="AUTHORS COPYING* ChangeLog NEWS README INSTALL"

src_prepare() {

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi

	# doc-install.pl was removed from glibmm, and is provided by mm-common now
	# This should not be needed if the tarball is generated with mm-common-0.9.3
	if use doc && has_version '>=dev-cpp/glibmm-2.27.97'; then
		mm-common-prepare --copy --force
		eautoreconf
	fi
}

src_compile() {
	gnome2_src_compile

	if use doc; then
		cd "${S}/docs/reference"
		make all
	fi
}

src_install() {
	gnome2_src_install

	if use doc ; then
		dohtml -r docs/reference/html/* docs/images/*
	fi

	if use examples; then
		find examples -type d -name '.deps' -exec rm -fr {} \; 2>/dev/null
		cp -R examples "${D}/usr/share/doc/${PF}"
	fi
}
