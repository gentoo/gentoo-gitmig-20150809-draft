# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.01.ebuild,v 1.1 2002/09/09 21:53:26 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND="${DEPEND}
	>=media-libs/libgd-2.0.1
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp Makefile.PL Makefile.PL.orig
	sed -e "s:my \$JPEG.*:my \$JPEG='y';:" \
		-e "s:my \$TTF.*:my \$TTF='y';:" \
		Makefile.PL.orig > Makefile.PL

	use X && ( \
		cp Makefile.PL Makefile.PL.orig
		sed -e "s:my \$XPM.*:my \$XPM='y';:" \
			Makefile.PL.orig > Makefile.PL
	)
}

src_install () {
	perl-module_src_install
	dohtml GD.html
}
