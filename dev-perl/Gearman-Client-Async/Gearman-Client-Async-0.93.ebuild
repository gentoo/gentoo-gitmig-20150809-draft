# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Client-Async/Gearman-Client-Async-0.93.ebuild,v 1.1 2007/05/09 08:14:56 robbat2 Exp $

inherit perl-module

DESCRIPTION="Asynchronous client module for Gearman for Danga::Socket applications"
HOMEPAGE="http://search.cpan.org/search?query=Gearman-Client-Async&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-perl/Gearman-1.07
		>=dev-perl/Danga-Socket-1.57
		dev-lang/perl"

mydoc="CHANGES README.txt TODO"
# testsuite requires gearman server
SRC_TEST="never"
