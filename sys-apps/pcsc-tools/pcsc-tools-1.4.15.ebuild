# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-tools/pcsc-tools-1.4.15.ebuild,v 1.2 2009/04/05 17:00:48 nerdboy Exp $

inherit eutils fdo-mime multilib

DESCRIPTION="PC/SC Architecture smartcard tools"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/pcsc-tools/"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/${PN}/${P}.tar.gz
	mirror://gentoo/smartcard_list.txt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
## ~arm waiting for keywords
IUSE="debug usb"

RDEPEND="usb? ( app-crypt/ccid )
	>=sys-apps/pcsc-lite-1.4.14
	dev-perl/pcsc-perl
	dev-perl/gtk2-perl"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	local myconf

	if use debug ; then
	    sed -i -e "s:-Wall -O2:${CFLAGS}:g" Makefile
	else
	    sed -i -e "s:-Wall -O2 -g:${CFLAGS}:g" Makefile
	fi

	make DESTDIR="${D}usr" all || die
}

src_install() {
	make DESTDIR="${D}usr" install || die

	# prepalldocs isn't supported any more?
	dodoc README Changelog

	doicon "${FILESDIR}"/smartcard.svg
	domenu gscriptor.desktop
	dosed "s:Categories=Utility;GTK;:Icon=smartcard.svg\\nCategories=System;:g" \
	    /usr/share/applications/gscriptor.desktop

	insinto /usr/share/pcsc
	doins "${DISTDIR}"/smartcard_list.txt
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	elog ""
	elog "If your card reader isn't recognized, you should make sure you"
	elog "have the latest copy of smartcard_list.txt.  Download it from:"
	elog "http://ludovic.rousseau.free.fr/softwares/pcsc-tools/smartcard_list.txt"
	elog ""
	elog "Note you may also need a firmware upgrade for your card reader in"
	elog "order for this to work.  See:"
	elog "http://symbolik.wordpress.com/2007/02/26/scm-scr-331-usb-smartcard-reader-firmware-upgrade/"
	elog ""
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
