# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-TimeZone/DateTime-TimeZone-0.30.ebuild,v 1.1 2004/10/17 02:24:01 mcummings Exp $

inherit perl-module

DESCRIPTION="Time zone object base class and factory"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha"
IUSE=""
SRC_TEST="do"
style="builder"

DEPEND="dev-perl/module-build
		>=dev-perl/Params-Validate-0.72
		dev-perl/Class-Singleton"

RDEPEND="dev-perl/DateTime"
