# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Storable/Storable-2.09.ebuild,v 1.4 2004/04/02 15:23:22 randy Exp $

inherit perl-module

DESCRIPTION="The Perl Storable Module"
SRC_URI="http://www.cpan.org/modules/by-module/Storable/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Storable/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 sparc ~mips s390"

DEPEND="|| ( dev-perl/Test-Simple >=dev-lang/perl-5.8.0-r12 )"
