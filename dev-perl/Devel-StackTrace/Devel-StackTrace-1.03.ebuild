# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.03.ebuild,v 1.3 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

DESCRIPTION="Devel-StackTrace module for perl"
SRC_URI="http://www.perl.com/CPAN/modules/by-modules/Devel/${P}.tar.gz"
HOMEPAGE="http://www.perl.com/CPAN/modules/by-modules/Devel/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
 	>=dev-perl/Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"

