# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Array-RefElem/Array-RefElem-1.00.ebuild,v 1.12 2007/01/14 22:22:01 mcummings Exp $

inherit perl-module

DESCRIPTION="Set up array elements as aliases"
HOMEPAGE="http://search.cpan.org/~gaas/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
