# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Date-Leapyear/Date-Leapyear-1.71.ebuild,v 1.14 2005/05/25 15:06:00 mcummings Exp $

inherit perl-module

DESCRIPTION="Simple Perl module that tracks Gregorian leap years"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"
IUSE=""

DEPEND="perl-core/Test-Simple
		perl-core/Test-Harness"
