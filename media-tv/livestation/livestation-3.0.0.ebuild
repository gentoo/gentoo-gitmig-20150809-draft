# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/livestation/livestation-3.0.0.ebuild,v 1.1 2009/12/01 17:03:29 ssuominen Exp $

inherit eutils

DESCRIPTION="Watch live, interactive TV and radio on the Livestation player"
HOMEPAGE="http://www.livestation.com"
SRC_URI="http://updates.${PN}.com/releases/${P/l/L}.run"

LICENSE="GPL-3 LGPL-3 Livestation-EULA"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

EMUL_VER=20081109

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-baselibs-${EMUL_VER}
	>=app-emulation/emul-linux-x86-xlibs-${EMUL_VER}
	>=app-emulation/emul-linux-x86-sdl-${EMUL_VER} )"
DEPEND=""

MY_PN=${PN/l/L}

QA_TEXTRELS="opt/${MY_PN}/lib/*"
QA_DT_HASH="opt/${MY_PN}/${MY_PN}.bin opt/${MY_PN}/lib/.* opt/${MY_PN}/plugins/imageformats/.*"
QA_PRESTRIPPED="opt/${MY_PN}/${MY_PN}.bin opt/${MY_PN}/lib/.* opt/${MY_PN}/plugins/imageformats/.*"

RESTRICT="mirror"
PROPERTIES="interactive"

S=${WORKDIR}/i386

pkg_setup() {
	check_license Livestation-EULA
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dest=/opt/${MY_PN}

	dodir ${dest}
	cp -dpR *.{bin,conf} plugins "${D}"/${dest} || die
	rm -f lib/{libcrypto.so.0.9.8,libssl.so.0.9.8,libXtst.so.6} || die
	exeinto ${dest}/lib
	doexe lib/* || die
	dosym plugins/imageformats ${dest}/imageformats || die
	dodoc README

	newicon "${FILESDIR}"/${PN}_icon.svg ${PN}.svg
	make_wrapper ${PN} ./${MY_PN}.bin ${dest} ${dest}/lib
	make_desktop_entry ${PN} ${MY_PN} ${PN}
}
