# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.35.ebuild,v 1.2 2003/02/13 11:08:33 vapier Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="GD::Graph is a perl5 module to create charts using the GD module."
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

src_compile () {
	perl-module_src_compile
}

src_install () {
	perl-module_src_install
}
