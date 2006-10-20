# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/prefork/prefork-1.01.ebuild,v 1.4 2006/10/20 23:42:15 agriffis Exp $

inherit perl-module

DESCRIPTION="Optimized module loading for forking or non-forking processes"
HOMEPAGE="http://search.cpan.org/search?module=prefork"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ia64 ~ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-File-Spec-0.80
	>=virtual/perl-Scalar-List-Utils-1.10
	dev-lang/perl"

