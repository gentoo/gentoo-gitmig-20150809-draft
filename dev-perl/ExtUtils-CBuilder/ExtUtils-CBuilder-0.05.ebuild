# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-CBuilder/ExtUtils-CBuilder-0.05.ebuild,v 1.1 2004/10/21 14:03:12 mcummings Exp $

inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kwilliams/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~alpha ~hppa ~mips ~ppc ~sparc ~amd64"
IUSE=""
SRC_TEST="do"
