# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Data::Hierarchy - Handle data in a hierarchical structure"
SRC_URI="http://www.cpan.org/modules/by-module/Data/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Data/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~mips ~ppc ~sparc x86"

DEPEND="${DEPEND}
	dev-perl/Clone"
