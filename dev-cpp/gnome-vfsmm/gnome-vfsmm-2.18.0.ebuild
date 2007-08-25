# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/gnome-vfsmm/gnome-vfsmm-2.18.0.ebuild,v 1.5 2007/08/25 16:58:31 beandog Exp $

inherit gnome2

DESCRIPTION="C++ bindings for gnome-vfs"
HOMEPAGE="http://gtkmm.sourceforge.net/"

LICENSE="LGPL-2.1"
SLOT="1.1"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
IUSE="doc examples"

# glibmm dep is because build fails with older versions...
RDEPEND=">=gnome-base/gnome-vfs-2.8.1
	>=dev-cpp/glibmm-2.12"
DEPEND=">=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog NEWS README INSTALL"

src_unpack() {
	gnome2_src_unpack

	if ! use examples; then
		# don't waste time building the examples
		sed -i 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' Makefile.in || \
			die "sed Makefile.in failed"
	fi
}

src_compile() {
	gnome2_src_compile

	if use doc; then
		cd "${S}"/docs/reference
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
		cp -R examples "${D}"/usr/share/doc/${PF}
	fi
}
