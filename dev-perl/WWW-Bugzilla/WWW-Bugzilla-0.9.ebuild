# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-0.9.ebuild,v 1.2 2007/06/21 18:00:11 mcummings Exp $

inherit perl-module

DESCRIPTION="WWW::Bugzilla - automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/B/BM/BMC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~bmc/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

RDEPEND="dev-perl/WWW-Mechanize
	dev-perl/Class-MethodMaker
	dev-lang/perl"

DEPEND="${RDEPEND}"
