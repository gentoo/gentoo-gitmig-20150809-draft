# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cups-pdf/cups-pdf-1.6.4.ebuild,v 1.1 2004/10/26 17:32:36 lanius Exp $

DESCRIPTION="Provides a virtual printer for CUPS to produce PDF files."
HOMEPAGE="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/"
MY_P="${PN}_${PV/_/}"
SRC_URI="http://cip.physik.uni-wuerzburg.de/~vrbehr/cups-pdf/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc ~ppc"
IUSE=""

DEPEND="net-print/cups
	virtual/ghostscript"

src_compile() {
	cd src
	sed -i -e "s:CPLOGTYPE 7:CPLOGTYPE 2:" \
		   -e "s:nobody:lp:" cups-pdf.h
	gcc ${CFLAGS} -o cups-pdf cups-pdf.c || die "Compilation failed."
}

src_install () {
	dodir /usr/lib/cups/backend
	exeinto /usr/lib/cups/backend
	doexe src/cups-pdf

	dodir /usr/share/cups/model
	insinto /usr/share/cups/model
	doins extra/PostscriptColor.ppd.gz

	dodoc ${FILESDIR}/README.gentoo
}

pkg_postinst () {
	einfo "You will find some informations about cups-pdf in this file:"
	einfo "/usr/share/doc/${PF}/README.gentoo.gz"
}
