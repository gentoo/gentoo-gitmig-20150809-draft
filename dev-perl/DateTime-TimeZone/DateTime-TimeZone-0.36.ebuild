# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-0.36.ebuild,v 1.2 2005/08/15 10:07:14 mcummings Exp $

inherit perl-module

DESCRIPTION="Time zone object base class and factory"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc ~alpha ~amd64"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/module-build
		>=dev-perl/Params-Validate-0.72
		>=dev-perl/Class-Singleton-1.03"

RDEPEND="dev-perl/DateTime"
