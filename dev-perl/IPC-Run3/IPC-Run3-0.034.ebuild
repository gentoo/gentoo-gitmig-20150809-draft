# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run3/IPC-Run3-0.034.ebuild,v 1.7 2006/08/17 21:21:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Run a subprocess in batch mode (a la system)"
SRC_URI="mirror://cpan/authors/id/R/RS/RSCHUPP/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
IUSE=""
SLOT="0"
LICENSE="as-is"
KEYWORDS="amd64 ia64 sparc x86"

SRC_TEST="do"

DEPEND=">=dev-perl/Test-Pod-1.00
	>=dev-perl/Test-Pod-Coverage-1.04
	dev-lang/perl"
RDEPEND="${DEPEND}"


