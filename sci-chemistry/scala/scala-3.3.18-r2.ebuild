# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/scala/scala-3.3.18-r2.ebuild,v 1.7 2012/10/19 10:26:43 jlec Exp $

EAPI="2"

inherit autotools fortran-2 eutils

DESCRIPTION="Scale together multiple observations of reflections"
HOMEPAGE="http://www.ccp4.ac.uk/dist/html/scala.html"
SRC_URI="ftp://ftp.mrc-lmb.cam.ac.uk/pub/pre/${P}.tar.gz"

SLOT="0"
LICENSE="ccp4"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	sci-libs/ccp4-libs
	virtual/lapack
	!<sci-chemistry/ccp4-6.1.2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gcc4.6.patch
	cp "${FILESDIR}"/{configure.ac,Makefile.am} "${S}"
	eautoreconf
}

src_install() {
	exeinto /usr/libexec/ccp4/bin/
	doexe ${PN} || die
	dosym ../libexec/ccp4/bin/${PN} /usr/bin/${PN}
	dodoc ${PN}.doc || die
	dohtml ${PN}.html || die
}
