# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.43.ebuild,v 1.3 2004/03/13 21:53:00 dholm Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="perl5 module to create charts using the GD module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~sparc alpha ia64 ~ppc"

DEPEND="dev-perl/GDTextUtil
		media-libs/libgd"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
