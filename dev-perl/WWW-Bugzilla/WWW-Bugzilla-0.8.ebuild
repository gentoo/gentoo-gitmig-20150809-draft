# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Bugzilla/WWW-Bugzilla-0.8.ebuild,v 1.7 2009/09/13 16:13:25 armin76 Exp $

inherit perl-module

DESCRIPTION="WWW::Bugzilla - automate interaction with bugzilla"
SRC_URI="mirror://cpan/authors/id/B/BM/BMC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~bmc/${P}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE=""

RDEPEND="dev-perl/WWW-Mechanize
	<dev-perl/Class-MethodMaker-2
	dev-lang/perl"

DEPEND="${RDEPEND}"
