# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/stan/stan-0.4.1.ebuild,v 1.2 2008/12/30 18:23:15 angelos Exp $

inherit autotools eutils

DESCRIPTION="Stan is a console application that analyzes binary streams and calculates statistical information."
HOMEPAGE="http://www.roqe.org/stan/"
SRC_URI="http://www.roqe.org/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-errno.patch"
	sed -i -e "s/-O3/${CFLAGS}/" configure.in || die "sed failed"
	eautoreconf
}

src_install() {
	einstall || die "einstall failed"
	dodoc README
}
