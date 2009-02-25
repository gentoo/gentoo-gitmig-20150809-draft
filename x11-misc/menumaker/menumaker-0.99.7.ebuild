# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/menumaker/menumaker-0.99.7.ebuild,v 1.1 2009/02/25 16:28:19 neurogeek Exp $

inherit autotools

DESCRIPTION="Utility that scans through the system and generates a menu of installed programs"
HOMEPAGE="http://menumaker.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="doc"

DEPEND="virtual/python
		doc? ( sys-apps/texinfo )"
MAKEOPTS="-j1"

src_unpack() {
	unpack ${A}
	cd "${S}"
	eautoreconf
}

src_compile() {
	econf
	emake || die "emake failed"

	if use doc; then
		cd "${S}/doc" && make html || die "Could not build docs"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README NEWS AUTHORS INSTALL

	if use doc; then
		dohtml "${S}"/doc/mmaker.html/*
	fi

}
