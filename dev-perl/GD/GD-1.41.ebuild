# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-1.41.ebuild,v 1.4 2004/02/17 22:31:38 agriffis Exp $

inherit perl-module eutils
CATEGORY="dev-perl"

DESCRIPTION="The Perl DBI Module"
SRC_URI="http://www.cpan.org/modules/by-module/GD/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE="X jpeg gif truetype"

DEPEND="${DEPEND}
	media-libs/libpng
	sys-libs/zlib
	=media-libs/libgd-1*
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
