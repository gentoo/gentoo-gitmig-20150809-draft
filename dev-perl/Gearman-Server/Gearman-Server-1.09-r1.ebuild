# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Server/Gearman-Server-1.09-r1.ebuild,v 1.1 2007/05/13 08:10:05 robbat2 Exp $

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

PATCHES="${FILESDIR}/$PN-1.09-Use-saner-name-in-process-listing.patch"

src_install() {
	perl-module_src_install
	newinitd ${FILESDIR}/gearmand-init.d-1.09 gearmand
	newconfd ${FILESDIR}/gearmand-conf.d-1.09 gearmand
}
