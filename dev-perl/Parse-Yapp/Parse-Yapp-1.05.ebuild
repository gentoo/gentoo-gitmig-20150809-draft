# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-Yapp/Parse-Yapp-1.05.ebuild,v 1.4 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

MY_P="${P/_/}"

DESCRIPTION="Compiles yacc-like LALR grammars to generate Perl OO parser modules"
HOMEPAGE="http://cpan.org/modules/by-module/Parse/${MY_P}.readme"
SRC_URI="http://cpan.org/modules/by-module/Parse/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 sparc  ~ppc ~alpha"

DEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}
