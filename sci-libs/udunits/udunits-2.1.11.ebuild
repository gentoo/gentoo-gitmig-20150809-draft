# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/udunits/udunits-2.1.11.ebuild,v 1.1 2009/12/07 03:41:00 bicatali Exp $

EAPI=2

DESCRIPTION="Library for manipulating units of physical quantities"
HOMEPAGE="http://www.unidata.ucar.edu/packages/udunits/"
SRC_URI="ftp://ftp.unidata.ucar.edu/pub/udunits/${P}.tar.gz"

SLOT="0"
LICENSE="UCAR-Unidata"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=""

IUSE="doc"

src_prepare() {
	# respect user's flags
	sed -i \
		-e 's/-O//g' configure || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CHANGE_LOG ANNOUNCEMENT
	doinfo udunits2.info prog/udunits2prog.info
	if use doc; then
		insinto /usr/share/doc/${PF}
		doins udunits2.html udunits2.pdf
		doins prog/udunits2prog.html prog/udunits2prog.pdf
	fi
}
