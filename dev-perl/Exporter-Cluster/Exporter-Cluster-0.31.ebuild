# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exporter-Cluster/Exporter-Cluster-0.31.ebuild,v 1.7 2006/08/05 03:28:57 mcummings Exp $

inherit perl-module

DESCRIPTION="Extension for easy multiple module imports"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/D/DH/DHAGEMAN/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ia64 x86"
IUSE=""
SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
