# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvthread/dvthread-0.13.4.ebuild,v 1.2 2010/04/12 19:21:55 maekke Exp $

EAPI=2

DESCRIPTION="Classes for threads and monitors, wrapped around the posix thread library"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/${PN}/download/${P}.tar.gz"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvthread/html/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="doc"

DEPEND=">=dev-libs/dvutil-1.0.5"

src_prepare() {
	sed -i \
		-e 's:dvthread doc m4:dvthread m4:' \
		Makefile.in || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS

	if use doc; then
		doman doc/man/man3/*.3
		dohtml -r doc/html/*
	fi
}
