# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Graph/Graph-0.20101.ebuild,v 1.7 2003/06/21 21:36:36 drobbins Exp $

inherit perl-module

DESCRIPTION="Data structure and ops for directed graphs"
SRC_URI="http://www.cpan.org/modules/by-module/Graph/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Graph/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~ppc ~sparc ~alpha"

newdepend "dev-perl/Heap"
