# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.06.ebuild,v 1.1 2003/03/02 02:10:08 vapier Exp $

inherit eutils perl-module
CATEGORY="dev-perl"

DESCRIPTION="interface to Thomas Boutell's gd library"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="jpeg freetype" #xpm

newdepend ">=media-libs/libgd-2.0.5
	jpeg? ( media-libs/jpeg )
	freetype? ( =media-libs/freetype-2* )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-opts.patch

	use jpeg \
		&& jpeg="y" \
		|| jpeg="n"
	use freetype \
		&& freetype="y" \
		|| freetype="n"
	cp Makefile.PL{,.orig}
	sed -e "s:GENTOO_JPEG:${jpeg}:" \
	 -e "s:GENTOO_FREETYPE:${freetype}:" \
		Makefile.PL.orig > Makefile.PL

	perl-module_src_prep
}

mydoc="GD.html"
