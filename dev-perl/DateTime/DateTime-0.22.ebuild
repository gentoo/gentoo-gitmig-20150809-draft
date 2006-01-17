# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime/DateTime-0.22.ebuild,v 1.10 2006/01/17 18:36:51 mcummings Exp $

inherit perl-module

DESCRIPTION="A date and time object"
HOMEPAGE="http://search.cpan.org/~drolsky/${P}/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Params-Validate-0.72
		perl-core/Time-Local
		dev-perl/File-Find-Rule
		>=dev-perl/DateTime-TimeZone-0.27
		>=dev-perl/DateTime-Locale-0.09
		dev-perl/Class-Factory-Util"
