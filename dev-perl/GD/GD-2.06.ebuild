# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.06.ebuild,v 1.2 2003/03/10 13:02:36 vapier Exp $

inherit eutils perl-module
CATEGORY="dev-perl"

DESCRIPTION="interface to Thomas Boutell's gd library"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="jpeg freetype X gif"

newdepend ">=media-libs/libgd-2.0.5
	jpeg? ( media-libs/jpeg )
	freetype? ( =media-libs/freetype-2* )
	X? ( virtual/x11 )
	gif? ( media-libs/giflib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-opts.patch
	use gif && epatch ${FILESDIR}/${PV}-gif-support.patch

	use jpeg \
		&& jpeg="y" \
		|| jpeg="n"
	use freetype \
		&& freetype="y" \
		|| freetype="n"
	use X \
		&& x="y" \
		|| x="n"
	cp Makefile.PL{,.orig}
	sed -e "s:GENTOO_JPEG:${jpeg}:" \
	 -e "s:GENTOO_FREETYPE:${freetype}:" \
	 -e "s:GENTOO_XPM:${x}:" \
		Makefile.PL.orig > Makefile.PL

	perl-module_src_prep
}

mydoc="GD.html"
