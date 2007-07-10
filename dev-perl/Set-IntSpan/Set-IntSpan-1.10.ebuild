# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Set-IntSpan/Set-IntSpan-1.10.ebuild,v 1.3 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Manages sets of integers"
SRC_URI="mirror://cpan/authors/id/S/SW/SWMCD/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~swmcd/"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc sparc ~x86"
SRC_TEST="do"

DEPEND="dev-lang/perl"
