# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Validate-Net/Validate-Net-0.5.ebuild,v 1.1 2004/06/10 20:06:54 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Format validation and more for Net:: related strings"
SRC_URI="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc"

SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
	dev-perl/Class-Default
	dev-perl/Class-Inspector"

