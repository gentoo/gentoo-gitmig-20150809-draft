# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-CUPS/Net-CUPS-0.41.ebuild,v 1.1 2006/05/01 21:00:16 mcummings Exp $

inherit perl-module

DESCRIPTION="CUPS C API Interface"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/D/DH/DHAGEMAN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~ia64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND=""
RDEPEND=">=net-print/cups-1.1.21
		dev-perl/Exporter-Cluster"

