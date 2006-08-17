# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Set-IntSpan/Set-IntSpan-1.09.ebuild,v 1.7 2006/08/17 22:15:40 mcummings Exp $

inherit perl-module

DESCRIPTION="Manages sets of integers"
SRC_URI="mirror://cpan/authors/id/S/SW/SWMCD/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Set/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc ~x86"
SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
