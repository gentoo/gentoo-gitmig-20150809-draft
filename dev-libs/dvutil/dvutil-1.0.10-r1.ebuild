# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-1.0.10-r1.ebuild,v 1.1 2012/02/25 12:42:09 ssuominen Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="C++ classes for files, dates, property lists, reference counted pointers, number conversion etc."
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz
	mirror://gentoo/${P}-asneeded.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc ssl static-libs"

RDEPEND="ssl? ( dev-libs/openssl:0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"

src_prepare() {
	epatch "${WORKDIR}"/${P}-asneeded.patch
	sed -i -e '/LDFLAGS.*all-static/d' dvutil/Makefile.am || die #362669
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with ssl)
}

src_install() {
	default
	use static-libs || rm -f "${ED}"usr/lib*/lib*.la
	use doc && dohtml -r doc/html/*
}
