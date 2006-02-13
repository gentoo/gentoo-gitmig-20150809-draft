# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-StackTrace/Devel-StackTrace-1.03.ebuild,v 1.11 2006/02/13 11:13:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Devel-StackTrace module for perl"
HOMEPAGE="http://www.perl.com/CPAN/modules/by-modules/Devel/${P}.readme"
SRC_URI="http://www.perl.com/CPAN/modules/by-modules/Devel/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND=">=virtual/perl-Test-Simple-0.47"

export OPTIMIZE="$CFLAGS"
