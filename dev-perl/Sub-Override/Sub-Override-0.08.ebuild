# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Override/Sub-Override-0.08.ebuild,v 1.1 2006/01/13 16:36:51 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for easily overriding subroutines"
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/O/OV/OVID/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

SRC_TEST="do"

DEPEND="perl-core/Test-Simple
		>=dev-perl/Test-Exception-0.21"
