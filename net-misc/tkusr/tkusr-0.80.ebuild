# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tkusr/tkusr-0.80.ebuild,v 1.1 2003/04/22 16:40:43 utx Exp $

DESCRIPTION="TkUsr is a small program that allows you to manage the Self-mode of USR/3COM Message (Plus), Professional Message modems."
HOMEPAGE="http://www.drolez.com/tkusr"
SRC_URI="http://www.drolez.com/tkusr/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${P}"

DEPEND=">=tcl-8.0
	>=tk-8.0"

RDEPEND=">=tcl-8.0
	>=tk-8.0"

src_unpack() {
	unpack "${PN}_${PV}.tar.gz"
	cd "${S}"
}

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING README
}

pkg_postinst() {
	einfo
	einfo "To use tkusr with your modem, please make a symbolic link of your modem device to /dev/modem."
	einfo "ie. ln -sf /dev/tts/0 /dev/modem"
	einfo
	einfo "Make sure you have sufficient rights to access the modem (you have to be in the tty group)."
	einfo
}
