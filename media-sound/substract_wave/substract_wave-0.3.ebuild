# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/substract_wave/substract_wave-0.3.ebuild,v 1.2 2009/02/06 14:10:48 sbriesen Exp $

inherit eutils toolchain-funcs flag-o-matic

IUSE=""

DESCRIPTION="substracts 2 mono wave files from each other by a factor specified on the command line"
HOMEPAGE="http://panteltje.com/panteltje/dvd/"
SRC_URI="http://panteltje.com/panteltje/dvd/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}.diff"
}

src_compile() {
	append-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE	-D_LARGEFILE64_SOURCE
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LIBRARY="-lm" || die "emake failed"
}

src_install() {
	dobin substract_wave
	dodoc CHANGES README mono-stereo.txt substract_wave.man
}
