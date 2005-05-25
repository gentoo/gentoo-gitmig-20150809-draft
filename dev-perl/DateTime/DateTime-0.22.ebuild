# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.22.ebuild,v 1.7 2005/05/25 15:35:33 mcummings Exp $

inherit perl-module

DESCRIPTION="A date and time object"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirrot://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Params-Validate-0.72
		perl-core/Time-Local
		dev-perl/File-Find-Rule
		>=dev-perl/DateTime-TimeZone-0.27
		>=dev-perl/DateTime-Locale-0.09
		dev-perl/Class-Factory-Util"
