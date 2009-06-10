# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/livestation/livestation-2.7.0-r1.ebuild,v 1.2 2009/06/10 15:29:50 ssuominen Exp $

inherit eutils

DESCRIPTION="Watch live, interactive TV and radio on the Livestation player"
HOMEPAGE="http://www.livestation.com"
SRC_URI="http://updates.${PN}.com/releases/${P/l/L}.run"

LICENSE="Livestation-EULA.txt"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="amd64? ( app-emulation/emul-linux-x86-baselibs
	app-emulation/emul-linux-x86-xlibs )"
DEPEND=""

MY_PN=${PN/l/L}
QA_TEXTRELS="opt/${MY_PN}/lib/*"
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
	exeinto ${dest}/lib
	rm -f lib/libXtst.so.6
	doexe lib/* || die "doexe failed"
	dosym plugins/imageformats ${dest}/imageformats || die "dosym failed"
	dodoc README

	newicon "${FILESDIR}"/${PN}_icon.svg ${PN}.svg
	make_wrapper ${PN} ./${MY_PN}.bin ${dest} ${dest}/lib
	make_desktop_entry ${PN} ${MY_PN} ${PN}
}
