# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/cdplay/cdplay-1.0.ebuild,v 1.5 2007/11/25 02:56:11 ranger Exp $

inherit toolchain-funcs

DESCRIPTION="a commandline CD Player"
HOMEPAGE="http://www.ta-sa.org/?entry=cdplay"
SRC_URI="http://www.ta-sa.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="!media-sound/cdtool"

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" \
		|| die "emake failed."
}

src_install() {
	dobin cdplay
	dodoc Changes CREDITS README TODO
}
