# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/tkusr/tkusr-0.80.ebuild,v 1.5 2004/06/25 00:15:34 agriffis Exp $

DESCRIPTION="TkUsr is a small program that allows you to manage the Self-mode of USR/3COM Message (Plus), Professional Message modems."
HOMEPAGE="http://www.drolez.com/tkusr"
SRC_URI="http://www.drolez.com/tkusr/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-lang/tcl-8.0
	>=dev-lang/tk-8.0"

src_compile() {
	emake || die
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc README
}

pkg_postinst() {
	einfo
	einfo "To use tkusr with your modem, please make a symbolic link of your modem device to /dev/modem."
	einfo "ie. ln -sf /dev/tts/0 /dev/modem"
	einfo
	einfo "Make sure you have sufficient rights to access the modem (you have to be in the tty group)."
	einfo
}
