# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Hierarchy/Data-Hierarchy-0.21.ebuild,v 1.5 2005/05/17 13:51:47 gustavoz Exp $

inherit perl-module

DESCRIPTION="Data::Hierarchy - Handle data in a hierarchical structure"
SRC_URI="mirror://cpan/authors/id/C/CL/CLKAO/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 sparc ~amd64 ~alpha ~mips ~ppc"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	dev-perl/Clone"
