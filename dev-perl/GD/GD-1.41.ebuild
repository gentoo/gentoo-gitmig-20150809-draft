# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-1.41.ebuild,v 1.8 2004/11/01 02:10:35 vapier Exp $

inherit perl-module eutils
CATEGORY="dev-perl"

DESCRIPTION="The Perl DBI Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="X jpeg gif truetype"

DEPEND="media-libs/libpng
	sys-libs/zlib
	=media-libs/gd-1*
	truetype? ( =media-libs/freetype-1* )
	jpeg? ( media-libs/jpeg )
	X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-makefile-opts.patch

	use gif \
		&& gif=1 \
		|| gif=0

	use jpeg \
		&& jpeg=1 \
		|| jpeg=0

	use X \
		&& x=1 \
		|| x=0

	use truetype \
		&& freetype=1 \
		|| freetype=0

	sed -i \
		-e "s:GENTOO_JPEG:${jpeg}:" \
		-e "s:GENTOO_TTF:${freetype}:" \
		-e "s:GENTOO_XPM:${x}:" \
		-e "s:GENTOO_GIF:${gif}:" \
		-e 's:-I/usr/local/include/gd:-I/usr/include/gd-1:' \
		Makefile.PL

	perl-module_src_prep
}

mydoc="GD.html"
