# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-0.2.ebuild,v 1.9 2006/08/06 01:01:45 mcummings Exp $

inherit perl-module

DESCRIPTION="automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/M/MC/MCVELLA/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mcvella/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc amd64"
IUSE=""

DEPEND="dev-perl/WWW-Mechanize
	dev-perl/Class-MethodMaker
	dev-lang/perl"
RDEPEND="${DEPEND}"


