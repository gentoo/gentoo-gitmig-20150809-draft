# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeakup/espeakup-0.60.ebuild,v 1.2 2009/04/17 21:26:11 williamh Exp $

DESCRIPTION="espeakup is a small lightweight connector for espeak and speakup"
HOMEPAGE="http://www.linux-speakup.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="app-accessibility/espeak"
RDEPEND="${DEPEND}
	app-accessibility/speakup"

src_compile() {
	emake || die "Compile failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed."
	dodoc README ToDo
	newconfd "${FILESDIR}"/espeakup.confd espeakup
	newinitd "${FILESDIR}"/espeakup.rc espeakup
}

pkg_postinst() {
	elog "To get espeakup to start automatically, it is currently recommended"
	echo "that you add it to the default run level, by giving the following"
	elog "command as root."
	elog
	elog "rc-update add espeakup default"
	elog
	elog "You can also set a default voice now for espeakup."
	elog "See /etc/conf.d/espeakup for how to do this."
}
