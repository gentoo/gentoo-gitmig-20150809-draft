# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Taint/Test-Taint-1.04.ebuild,v 1.11 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Tools to test taintedness"
HOMEPAGE="http://search.cpan.org/~petdance/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
