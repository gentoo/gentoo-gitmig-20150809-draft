# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Sub-Override/Sub-Override-0.05.ebuild,v 1.5 2005/05/21 17:34:08 luckyduck Exp $

inherit perl-module

DESCRIPTION="Perl extension for easily overriding subroutines"
HOMEPAGE="http://www.cpan.org/modules/by-module/HTML/${P}.readme"
SRC_URI="mirror://cpan/authors/id/O/OV/OVID/${P}.tar.gz"
IUSE=""
LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~ppc sparc amd64"

SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
		dev-perl/Test-Exception"
