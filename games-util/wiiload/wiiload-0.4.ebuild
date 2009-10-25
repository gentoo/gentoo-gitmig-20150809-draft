# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wiiload/wiiload-0.4.ebuild,v 1.2 2009/10/25 15:18:22 maekke Exp $

inherit toolchain-funcs

DESCRIPTION="load homebrew apps over the network to your Wii"
HOMEPAGE="http://wiibrew.org/wiki/Wiiload"
SRC_URI="http://wiibrew.org/w/images/5/5e/Wiiload-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${PN}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin wiiload || die
}
