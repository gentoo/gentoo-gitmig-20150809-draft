# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.5.ebuild,v 1.9 2005/08/26 03:04:01 agriffis Exp $

inherit perl-module

DESCRIPTION="Format validation and more for Net:: related strings"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="perl-core/Test-Simple
	dev-perl/Class-Default
	dev-perl/Class-Inspector"
