# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.02.ebuild,v 1.3 2002/12/15 10:44:13 bjb Exp $

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

