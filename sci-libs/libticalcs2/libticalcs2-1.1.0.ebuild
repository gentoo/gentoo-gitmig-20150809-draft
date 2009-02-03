# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libticalcs2/libticalcs2-1.1.0.ebuild,v 1.1 2009/02/03 14:49:43 bicatali Exp $

EAPI=2
inherit eutils

DESCRIPTION="Library for communication with TI calculators"
HOMEPAGE="http://lpg.ticalc.org/prj_tilp/"
SRC_URI="mirror://sourceforge/gtktiemu/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc nls threads"

RDEPEND=">=dev-libs/glib-2.6.0
	>=sci-libs/libticables2-1.2.0
	>=sci-libs/libticonv-1.1.0
	>=sci-libs/libtifiles2-1.1.0
	nls? ( virtual/libintl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}"/${P}-locale.patch
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable threads)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS LOGO NEWS README ChangeLog docs/api.txt
	if use doc; then
		dohtml docs/html/*
	fi
}
