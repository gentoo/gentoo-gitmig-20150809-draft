# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Exception/Test-Exception-0.20.ebuild,v 1.3 2005/04/09 02:25:40 gustavoz Exp $

inherit perl-module

DESCRIPTION="test functions for exception based code"
HOMEPAGE="http://search.cpan.org/~adie/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADIE/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
		>=dev-perl/Test-Builder-Tester-1.01
		dev-perl/Sub-Uplevel"
