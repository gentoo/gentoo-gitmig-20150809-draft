# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-astronomy/esorex/esorex-3.8.3-r1.ebuild,v 1.2 2011/02/24 17:25:03 bicatali Exp $

EAPI=2

inherit autotools eutils

DESCRIPTION="ESO Recipe Execution Tool to exec cpl scripts"
HOMEPAGE="http://www.eso.org/sci/software/cpl/esorex.html"
SRC_URI="ftp://ftp.eso.org/pub/cpl/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples"

DEPEND=">=sci-astronomy/cpl-5.2"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-cfitsio.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS NEWS TODO BUGS ChangeLog || die
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
