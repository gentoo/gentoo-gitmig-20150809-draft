# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.12.ebuild,v 1.3 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

DESCRIPTION="Exception::Class module for perl"
SRC_URI="http://www.cpan.org/modules/by-module/Exception/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Exception/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.01
	>=dev-perl/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"
