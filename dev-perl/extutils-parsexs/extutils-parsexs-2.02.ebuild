# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-parsexs/extutils-parsexs-2.02.ebuild,v 1.8 2004/10/19 07:58:35 absinthe Exp $

inherit perl-module

MY_P=ExtUtils-ParseXS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${MY_P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 alpha ~hppa ~mips ~ppc ~sparc amd64"
IUSE=""
