# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.07.ebuild,v 1.11 2004/10/19 07:45:58 absinthe Exp $

inherit eutils perl-module

DESCRIPTION="interface to Thomas Boutell's gd library"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa ia64 amd64 ~mips"
IUSE="jpeg truetype X gif"

DEPEND=">=media-libs/gd-2.0.5
	media-libs/libpng
	sys-libs/zlib
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
