# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-2.33.2.ebuild,v 1.3 2011/04/14 17:55:19 pacho Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 autotools

MY_PN="${PN/pp/++}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="C++ wrapper for the libxml2 XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="doc"

RDEPEND=">=dev-libs/libxml2-2.6.1
	>=dev-cpp/glibmm-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( || (
		<dev-cpp/glibmm-2.27.97:2[doc?]
		>=dev-cpp/mm-common-0.9.3
	) )
"
pkg_setup() {
	G2CONF="${G2CONF} $(use_enable doc documentation)"
	DOCS="AUTHORS ChangeLog NEWS README*"
}

src_prepare() {
	gnome2_src_prepare

	# don't waste time building the examples
	sed 's/^\(SUBDIRS =.*\)examples\(.*\)$/\1\2/' \
		-i Makefile.am Makefile.in || die "sed Makefile.in failed"

	# doc-install.pl was removed from glibmm, and is provided by mm-common now
	# This should not be needed if the tarball is generated with mm-common-0.9.3
	if use doc && has_version '>=dev-cpp/glibmm-2.27.97'; then
		mm-common-prepare --copy --force
		eautoreconf
	fi
}

src_install() {
	gnome2_src_install

	rm -fr "${ED}"usr/share/doc/libxml++*
	use doc && dohtml docs/reference/html/*
}
