# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-CBuilder/ExtUtils-CBuilder-0.03.ebuild,v 1.3 2004/07/14 17:28:32 agriffis Exp $

inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"
SRC_URI="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/K/KW/KWILLIAMS/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~alpha ~hppa ~mips ~ppc ~sparc ~amd64"
IUSE=""
SRC_TEST="do"
