# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.35.ebuild,v 1.3 2003/03/01 05:02:38 vapier Exp $

inherit perl-module

CATEGORY="dev-perl"
DESCRIPTION="perl5 module to create charts using the GD module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86"

DEPEND="dev-perl/GDTextUtil"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
