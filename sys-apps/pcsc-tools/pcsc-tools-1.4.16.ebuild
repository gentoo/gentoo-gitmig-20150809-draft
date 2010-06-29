# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-tools/pcsc-tools-1.4.16.ebuild,v 1.1 2010/06/29 00:29:57 arfrever Exp $

EAPI="3"

inherit eutils fdo-mime multilib

DESCRIPTION="PC/SC Architecture smartcard tools"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/pcsc-tools/"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/${PN}/${P}.tar.gz
	mirror://gentoo/smartcard_list.txt"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
## ~arm waiting for keywords
IUSE="debug gtk usb"

RDEPEND="usb? ( app-crypt/ccid )
	>=sys-apps/pcsc-lite-1.4.14
	dev-perl/pcsc-perl
	gtk? ( dev-perl/gtk2-perl )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	if ! use gtk; then
	    epatch "${FILESDIR}"/${PN}_no-gtk.patch
	fi

	if use debug; then
	    sed -i -e "s:-Wall -O2:${CFLAGS}:g" Makefile
	else
	    sed -i -e "s:-Wall -O2 -g:${CFLAGS}:g" Makefile
	fi

	sed -i -e "s:/usr/local:/usr:" Makefile

	make DESTDIR="${D}usr" all || die
}

src_install() {
	make DESTDIR="${D}usr" install || die

	# prepalldocs isn't supported any more?
	dodoc README Changelog

	if use gtk; then
	    doicon "${FILESDIR}"/smartcard.svg
	    domenu gscriptor.desktop
	    dosed "s:Categories=Utility;GTK;:Icon=smartcard.svg\\nCategories=System;:g" \
	        /usr/share/applications/gscriptor.desktop
	fi

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
