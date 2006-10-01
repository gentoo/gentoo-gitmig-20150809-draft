# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/declick/declick-0.6.5.ebuild,v 1.2 2006/10/01 20:22:52 sbriesen Exp $

inherit eutils toolchain-funcs

DESCRIPTION="declick is a dynamic digital declicker for audio sample files"
HOMEPAGE="http://home.snafu.de/wahlm/dl8hbs/declick.html"
SRC_URI="http://home.snafu.de/wahlm/dl8hbs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	# add $LDFLAGS to link command
	sed -i -e "s:\(-o declick\):\$(LDFLAGS) \1:g" Makefile
}

src_compile() {
	emake CC="$(tc-getCC)" COPTS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_install() {
	dobin declick
	dodoc README
}
