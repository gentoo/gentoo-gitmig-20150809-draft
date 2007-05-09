# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Server/Gearman-Server-1.08.ebuild,v 1.1 2007/05/09 08:13:47 robbat2 Exp $

inherit perl-module

DESCRIPTION="Gearman distributed job system - worker/client connector"
HOMEPAGE="http://search.cpan.org/search?query=Gearman-Server&mode=dist"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-perl/Danga-Socket-1.57
		>=dev-perl/Gearman-1.07
		dev-lang/perl"

mydoc="CHANGES"
