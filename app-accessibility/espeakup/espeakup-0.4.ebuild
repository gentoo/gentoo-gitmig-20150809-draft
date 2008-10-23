# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeakup/espeakup-0.4.ebuild,v 1.1 2008/10/23 13:27:28 williamh Exp $

DESCRIPTION="espeakup is a small lightweight connector for espeak and speakup"
HOMEPAGE="http://www.linux-speakup.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	newinitd "${FILESDIR}"/espeakup.rc espeakup
}

pkg_postinst() {
	elog "To get espeakup to start automatically, it is currently recommended"
	echo "that you add it to the default run level, by giving the following"
	elog "command as root."
	elog
	elog "rc-update add espeakup default"
}
