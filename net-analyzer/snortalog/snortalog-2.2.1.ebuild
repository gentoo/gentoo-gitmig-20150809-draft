# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.2.1.ebuild,v 1.8 2004/11/22 19:04:53 eldad Exp $

DESCRIPTION="a powerful perl script that summarizes snort logs"
SRC_URI="http://jeremy.chartier.free.fr/${PN}/${PN}_v${PV}.tgz"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/"

# Missing dep: dev-perl/HTML-HTMLDoc. Do not move to stable. see bug 72090. (2004 Nov 22 eldad)
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

S=${WORKDIR}/${PN}_v${PV%.?}

RDEPEND="dev-lang/perl
	dev-perl/GDGraph
	dev-perl/Getopt-Long
	dev-perl/DB_File
	dev-perl/perl-tk"

src_compile() {
	einfo "Nothing to compile."
}

src_install () {

	dodir /usr/bin
	cp ${S}/snortalog.pl ${D}/usr/bin

	dodoc CHANGES README domains hw rules snortalog_v2.2.0.pdf
}
