# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/babytrans/babytrans-0.9.2-r2.ebuild,v 1.7 2004/11/30 20:59:09 swegener Exp $

inherit eutils

DESCRIPTION="BabyTrans is a Linux clone of the popular Babylon Translator for Windows."
SRC_URI="http://fjolliton.free.fr/babytrans/test/${P}.tar.gz"
HOMEPAGE="http://fjolliton.free.fr/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""

RDEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	app-dicts/babytrans-en"

src_unpack() {
	unpack ${A}
	cd ${S}/src
	epatch ${FILESDIR}/${P}-gcc.patch
}

src_install() {
	einstall || die

	insinto /usr/share/babytrans
	doins ${FILESDIR}/dictionary
	dodoc AUTHORS README
}

pkg_postinst() {
	einfo ""
	einfo "Now you should install one of the babytrans dictionaries"
	einfo "available in portage. You can find then in $PORTDIR under"
	einfo "the app-dicts category"
	einfo ""
}
