# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.02.ebuild,v 1.4 2003/02/13 11:05:28 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Devel-StackTrace module for perl"
SRC_URI="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/modules/by-authors/id/D/DR/DROLSKY/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
 	>=dev-perl/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"

