# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-1.32-r1.ebuild,v 1.4 2002/07/25 04:13:26 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=media-libs/libgd-1.8.3
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
	base_src_install
	dohtml GD.html
}
