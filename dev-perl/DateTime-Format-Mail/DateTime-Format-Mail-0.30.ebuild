# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-Mail/DateTime-Format-Mail-0.30.ebuild,v 1.1 2006/11/19 16:36:31 mcummings Exp $

inherit perl-module

DESCRIPTION="A date and time object"
HOMEPAGE="http://search.cpan.org/~drolsky/"
SRC_URI="mirror://cpan/authors/id/D/DR/DROLSKY/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND=">=dev-perl/Params-Validate-0.67
		>=dev-perl/DateTime-0.17*
		dev-lang/perl"
DEPEND="${RDEPEND}
		dev-perl/module-build"
