# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsutils/cvsutils-0.2.5.ebuild,v 1.1 2009/09/12 00:12:34 patrick Exp $

inherit autotools

DESCRIPTION="A small bundle of utilities to work with CVS repositories"
HOMEPAGE="http://www.red-bean.com/cvsutils/"
SRC_URI="http://www.red-bean.com/cvsutils/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="dev-lang/perl"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${S}
	# clean up some of the internals quickly
	autoupdate || die "autoupdate failed"
	eautoreconf || die "eautoreconf failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS README THANKS TODO NEWS
}
