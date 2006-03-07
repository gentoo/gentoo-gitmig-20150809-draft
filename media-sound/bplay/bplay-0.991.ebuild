# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bplay/bplay-0.991.ebuild,v 1.17 2006/03/07 13:32:09 flameeyes Exp $

inherit toolchain-funcs

IUSE=""

DESCRIPTION="No-frills command-line buffered player and recorder."
HOMEPAGE="http://www.amberdata.demon.co.uk/bplay/"
SRC_URI="http://www.amberdata.demon.co.uk/bplay/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc sparc x86"

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS} -DUSEBUFFLOCK" bplay || die
}

src_install () {
	dobin bplay || die
	dosym /usr/bin/bplay /usr/bin/brec
	doman bplay.1 brec.1
	dodoc README
}
