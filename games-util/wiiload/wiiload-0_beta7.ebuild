# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-util/wiiload/wiiload-0_beta7.ebuild,v 1.1 2008/06/02 08:29:20 vapier Exp $

inherit toolchain-funcs

MY_PV=${PV/0_beta/beta_}
MY_P="the_homebrew_channel-${MY_PV}"
DESCRIPTION="load homebrew apps over the network to your Wii"
HOMEPAGE="http://hbc.hackmii.com/"
SRC_URI="http://hbc.hackmii.com/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./wiiload.tar.gz
}

src_compile() {
	cd wiiload
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" LFLAGS="${LDFLAGS}" || die
}

src_install() {
	dobin wiiload/wiiload || die
}
