# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.20105.ebuild,v 1.4 2005/03/30 22:28:05 gustavoz Exp $

inherit perl-module

DESCRIPTION="Data structure and ops for directed graphs"
SRC_URI="http://www.cpan.org/modules/by-module/Graph/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Graph/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
SRC_TEST="do"

DEPEND="dev-perl/Heap"
