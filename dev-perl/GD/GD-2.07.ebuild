# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.07.ebuild,v 1.1 2003/06/26 15:16:33 vapier Exp $

inherit eutils perl-module
CATEGORY="dev-perl"

IUSE="jpeg truetype X gif"

DESCRIPTION="interface to Thomas Boutell's gd library"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=media-libs/libgd-2.0.5
	jpeg? ( media-libs/jpeg )
	truetype? ( =media-libs/freetype-2* )
	X? ( virtual/x11 )
	gif? ( media-libs/giflib )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-opts.patch
	use gif && epatch ${FILESDIR}/${PV}-gif-support.patch

	use jpeg \
		&& jpeg=1 \
		|| jpeg=0

	use truetype \
		&& freetype=1 \
		|| freetype=0

	use X \
		&& x=1 \
		|| x=0

	cp Makefile.PL{,.orig}
	sed \
		-e "s:GENTOO_JPEG:${jpeg}:" \
		-e "s:GENTOO_FREETYPE:${freetype}:" \
		-e "s:GENTOO_XPM:${x}:" \
		Makefile.PL.orig > Makefile.PL

	perl-module_src_prep
}

mydoc="GD.html"
