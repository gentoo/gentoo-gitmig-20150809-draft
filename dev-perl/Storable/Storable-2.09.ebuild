# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Storable/Storable-2.09.ebuild,v 1.7 2004/06/01 23:00:36 tgall Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 sparc ~mips ~alpha arm s390 ppc64"
IUSE=""

DEPEND="|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
