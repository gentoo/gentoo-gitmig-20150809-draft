# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snortalog/snortalog-2.2.1.ebuild,v 1.11 2005/05/24 14:48:23 mcummings Exp $

DESCRIPTION="a powerful perl script that summarizes snort logs"
HOMEPAGE="http://jeremy.chartier.free.fr/snortalog/"
SRC_URI="http://jeremy.chartier.free.fr/${PN}/${PN}_v${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S="${WORKDIR}/${PN}_v${PV%.?}"

RDEPEND="dev-lang/perl
	dev-perl/GDGraph
	dev-perl/Getopt-Long
	perl-core/DB_File
	dev-perl/HTML-HTMLDoc
	dev-perl/perl-tk"

src_install () {
	dobin snortalog.pl || die "dobin failed"
	insinto /etc/${PN}
	doins domains hw rules
	dodoc CHANGES README snortalog_v2.2.0.pdf
}
