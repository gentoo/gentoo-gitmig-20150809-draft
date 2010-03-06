# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvutil/dvutil-1.0.10.ebuild,v 1.1 2010/03/06 21:45:51 ssuominen Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="Provides some general C++ utility classes for files, directories, dates, property lists, reference counted pointers, number conversion etc. "
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvutil/html/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc ssl"

RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-asneeded.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_with ssl)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		dohtml -r doc/html/*
	fi
}
