# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Hierarchy/Data-Hierarchy-0.15.ebuild,v 1.4 2004/09/29 10:53:44 mcummings Exp $

inherit perl-module

DESCRIPTION="Data::Hierarchy - Handle data in a hierarchical structure"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~mips ~ppc ~sparc x86"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/Clone"
