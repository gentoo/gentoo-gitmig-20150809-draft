# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Quick implimentation of readline utilities." 
SRC_URI="http://search.cpan.org/CPAN/authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"
HOMEPAGE="http:/search.cpan.org/src/ILYAZ/Term-ReadLine-Perl-1.0203/README"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND="${DEPEND}"
