# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Storable/Storable-2.07-r1.ebuild,v 1.2 2005/05/25 15:12:41 mcummings Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="ia64 x86 amd64 ~ppc alpha sparc hppa mips"

DEPEND="|| ( perl-core/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
