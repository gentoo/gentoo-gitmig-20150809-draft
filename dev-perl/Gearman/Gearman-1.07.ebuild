# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman/Gearman-1.07.ebuild,v 1.1 2007/05/09 08:12:15 robbat2 Exp $

inherit perl-module

DESCRIPTION="Gearman distributed job system"
HOMEPAGE="http://search.cpan.org/search?query=Gearman&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/string-crc32
		dev-lang/perl"

mydoc="CHANGES HACKING TODO"
# testsuite requires gearman server
SRC_TEST="never"
