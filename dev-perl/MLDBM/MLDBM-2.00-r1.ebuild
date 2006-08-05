# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MLDBM/MLDBM-2.00-r1.ebuild,v 1.18 2006/08/05 13:41:57 mcummings Exp $

inherit perl-module

DESCRIPTION="A multidimensional/tied hash Perl Module"
SRC_URI="mirror://cpan/authors/id/G/GS/GSAR/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gsar/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
