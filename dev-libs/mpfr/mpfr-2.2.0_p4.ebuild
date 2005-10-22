# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mpfr/mpfr-2.2.0_p4.ebuild,v 1.3 2005/10/22 19:02:08 halcy0n Exp $

inherit eutils

MY_PV=${PV/_p*}
MY_P=${PN}-${MY_PV}
PLEVEL=${PV/*p}
DESCRIPTION="library for multiple-precision floating-point computations with exact rounding"
HOMEPAGE="http://www.mpfr.org/"
SRC_URI="http://www.mpfr.org/mpfr-current/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=dev-libs/gmp-4.1.4-r2"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	for ((i=1; i<=PLEVEL; ++i)) ; do
		epatch "${FILESDIR}"/${MY_PV}/patch$(printf '%02d' ${i})
	done
}

src_compile() {
	econf \
		--enable-shared \
		--enable-static \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
	dohtml *.html
}
