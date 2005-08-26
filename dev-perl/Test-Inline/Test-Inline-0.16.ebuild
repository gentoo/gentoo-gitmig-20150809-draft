# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Inline/Test-Inline-0.16.ebuild,v 1.14 2005/08/26 03:16:53 agriffis Exp $

inherit perl-module

MY_P=Test-Inline-${PV}
DESCRIPTION="Inline test suite support for Perl"
HOMEPAGE="http://search.cpan.org/search?dist=Test-Inline"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Memoize
	perl-core/Test-Harness
	perl-core/Test-Simple"

S=${WORKDIR}/${MY_P}
