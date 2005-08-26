# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Chart-Math-Axis/Chart-Math-Axis-0.3.ebuild,v 1.12 2005/08/26 03:12:10 agriffis Exp $

inherit perl-module

DESCRIPTION="Implements an algorithm to find good values for chart axis"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.orga/~adamk/${P}"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=perl-core/Math-BigInt-1.70
	dev-perl/Clone
	perl-core/Test-Simple"
