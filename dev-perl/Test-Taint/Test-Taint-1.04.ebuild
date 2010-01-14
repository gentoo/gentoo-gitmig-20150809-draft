# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Taint/Test-Taint-1.04.ebuild,v 1.14 2010/01/14 15:02:24 grobian Exp $

inherit perl-module

DESCRIPTION="Tools to test taintedness"
HOMEPAGE="http://search.cpan.org/~petdance/"
SRC_URI="mirror://cpan/authors/id/P/PE/PETDANCE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
