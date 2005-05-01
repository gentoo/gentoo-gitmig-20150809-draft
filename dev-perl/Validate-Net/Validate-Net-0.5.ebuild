# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.5.ebuild,v 1.7 2005/05/01 18:22:35 slarti Exp $

inherit perl-module

DESCRIPTION="Format validation and more for Net:: related strings"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ~ppc sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
	dev-perl/Class-Default
	dev-perl/Class-Inspector"
