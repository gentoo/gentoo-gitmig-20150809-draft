# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDTextUtil/GDTextUtil-0.86.ebuild,v 1.1 2003/12/25 20:06:36 mcummings Exp $

IUSE=""

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="Text utilities for use with GD"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ~sparc"

DEPEND="dev-perl/GD"

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
