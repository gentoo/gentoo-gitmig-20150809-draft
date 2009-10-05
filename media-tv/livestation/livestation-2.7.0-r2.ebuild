# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/livestation/livestation-2.7.0-r2.ebuild,v 1.3 2009/10/05 08:28:30 ssuominen Exp $

inherit eutils

DESCRIPTION="Watch live, interactive TV and radio on the Livestation player"
HOMEPAGE="http://www.livestation.com"
SRC_URI="http://updates.${PN}.com/releases/${P/l/L}.run"

LICENSE="Livestation-EULA.txt"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="amd64? ( >=app-emulation/emul-linux-x86-baselibs-20081109
	>=app-emulation/emul-linux-x86-xlibs-20081109
	>=app-emulation/emul-linux-x86-sdl-20081109 )"
DEPEND=""

MY_PN=${PN/l/L}

QA_TEXTRELS="opt/${MY_PN}/lib/*"

QA_DT_HASH="opt/${MY_PN}/${MY_PN}.bin opt/${MY_PN}/lib/.* opt/${MY_PN}/plugins/imageformats/.*"

RESTRICT="mirror strip"
PROPERTIES="interactive"

S=${WORKDIR}/i386

pkg_setup() {
	check_license
}

src_unpack() {
	unpack_makeself
}

src_install() {
	local dest=/opt/${MY_PN}

	dodir ${dest}
	cp -dpR *.{bin,conf} plugins "${D}"/${dest} || die "cp failed"
	rm -f lib/libXtst.so.6 || die "rm failed"
	exeinto ${dest}/lib
	doexe lib/* || die "doexe failed"
	dosym plugins/imageformats ${dest}/imageformats || die "dosym failed"
	dodoc README

	newicon "${FILESDIR}"/${PN}_icon.svg ${PN}.svg
	make_wrapper ${PN} ./${MY_PN}.bin ${dest} ${dest}/lib
	make_desktop_entry ${PN} ${MY_PN} ${PN}
}
