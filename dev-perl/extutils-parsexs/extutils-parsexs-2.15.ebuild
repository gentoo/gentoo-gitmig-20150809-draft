# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-parsexs/extutils-parsexs-2.15.ebuild,v 1.8 2006/04/24 05:24:26 kumba Exp $

inherit perl-module

MY_P=ExtUtils-ParseXS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
HOMEPAGE="http://search.cpan.org/~kwilliams/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="dev-perl/ExtUtils-CBuilder
		dev-perl/module-build"

SRC_TEST="do"
