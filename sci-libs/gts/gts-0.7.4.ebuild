# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/gts/gts-0.7.4.ebuild,v 1.2 2006/03/17 05:05:11 deltacow Exp $

DESCRIPTION="GNU Triangulated Surface Library"
LICENSE="LGPL-2"
HOMEPAGE="http://gts.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-libs/glib-2.4.0
		sys-apps/gawk
		sys-devel/libtool
		dev-util/pkgconfig"

src_compile() {
	econf || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO

	# install additional docs
	if use doc; then
		dohtml doc/html/*
		docinto examples
		dodoc examples/*
	fi
}

