# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-0.2.ebuild,v 1.1 2003/08/26 17:21:03 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Implements an algorithm to find good values for chart axis"
SRC_URI="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/A/AD/ADAMK/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~alpha ~arm ~hppa ~mips ~ppc ~sparc"

DEPEND="dev-perl/Math-BigInt
	dev-perl/Test-Simple"

