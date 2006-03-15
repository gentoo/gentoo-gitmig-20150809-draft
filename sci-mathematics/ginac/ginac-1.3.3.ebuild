# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/ginac/ginac-1.3.3.ebuild,v 1.1 2006/03/15 15:18:30 markusle Exp $

inherit eutils

DESCRIPTION="GiNaC : a free CAS (computer algebra system)"
SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/GiNaC/${P}.tar.bz2"
HOMEPAGE="http://www.ginac.de/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc"
IUSE=""

DEPEND="sci-libs/cln"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/ginac-1.3.3-gcc4.1-gentoo.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
