# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-parsexs/extutils-parsexs-2.08.ebuild,v 1.5 2004/10/22 16:57:45 mcummings Exp $

inherit perl-module

MY_P=ExtUtils-ParseXS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~alpha ~hppa ~mips ~ppc sparc ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/ExtUtils-CBuilder"
