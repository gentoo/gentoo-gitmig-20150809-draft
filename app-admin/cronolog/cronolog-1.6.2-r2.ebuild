# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cronolog/cronolog-1.6.2-r2.ebuild,v 1.6 2007/01/04 12:44:12 flameeyes Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="1.4"

inherit eutils autotools

DESCRIPTION="Cronolog apache logfile rotator"
HOMEPAGE="http://cronolog.org/"
SRC_URI="http://cronolog.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-patches/*.txt

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
