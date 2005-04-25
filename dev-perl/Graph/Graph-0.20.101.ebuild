# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.20.101.ebuild,v 1.1 2005/04/25 17:18:41 mcummings Exp $

inherit perl-module
MY_PV=${PV/20.101/20101}
MY_P="${PN}-${MY_PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="Data structure and ops for directed graphs"
SRC_URI="http://www.cpan.org/modules/by-module/Graph/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Graph/${MY_P}.readme"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="dev-perl/Heap"
