# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/scala/scala-3.3.18.ebuild,v 1.1 2010/02/04 21:03:27 jlec Exp $

EAPI="2"

inherit autotools fortran

FORTRAN="gfortran ifc"

DESCRIPTION="scale together multiple observations of reflections"
HOMEPAGE="http://www.ccp4.ac.uk/dist/html/scala.html"
SRC_URI="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/${P}.tar.gz"

LICENSE="ccp4"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	sci-libs/ccp4-libs
	virtual/lapack
	!<sci-chemistry/ccp4-6.1.2"
DEPEND="${RDEPEND}"

src_prepare() {
	cp "${FILESDIR}"/{configure.ac,Makefile.am} "${S}"
	eautoreconf
}

src_install() {
	dobin ${PN} || die
	dodoc ${PN}.doc || die
	dohtml ${PN}.html || die
}
