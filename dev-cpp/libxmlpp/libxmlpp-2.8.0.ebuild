# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/libxmlpp/libxmlpp-2.8.0.ebuild,v 1.3 2005/02/25 02:12:29 joem Exp $

IUSE="doc"

inherit gnome2

MY_P=${P/pp/++}
S=${WORKDIR}/${MY_P}

DESCRIPTION="C++ wrapper for the libxml XML parser library"
HOMEPAGE="http://libxmlplusplus.sourceforge.net/"
SRC_URI="mirror://gnome/sources/libxml++/${PV%.*}/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="2.6"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=dev-libs/libxml2-2.6.1
	>=dev-cpp/glibmm-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( app-doc/doxygen )"

MAKEOPTS="${MAKEOPTS} -j1"

src_compile() {
	gnome2_src_compile
	if use doc ; then
		cd ${S}/docs/reference
		emake || die "failed to build docs"
	fi
}

src_install() {
	gnome2_src_install
	use doc && dohtml docs/reference/${PV%.*}/html/*
}

DOCS="AUTHORS ChangeLog NEWS README*"
