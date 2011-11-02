# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/isl/isl-0.07-r1.ebuild,v 1.1 2011/11/02 18:39:40 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A library for manipulating integer points bounded by affine constraints."
HOMEPAGE="http://www.kotnet.org/~skimo/isl/"
SRC_URI="http://www.kotnet.org/~skimo/isl/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="dev-libs/gmp"
DEPEND="${RDEPEND}"

DOCS=( ChangeLog AUTHORS doc/manual.pdf )

src_prepare() {
	epatch "${FILESDIR}"/${PN}-0.07-gdb-autoload-dir.patch

	# m4/ax_create_pkgconfig_info.m4 is broken but avoid eautoreconf
	sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die #382737
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/libisl.la
}
