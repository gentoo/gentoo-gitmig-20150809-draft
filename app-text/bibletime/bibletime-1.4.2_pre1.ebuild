# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.4.2_pre1.ebuild,v 1.9 2005/03/24 00:42:37 luckyduck Exp $

inherit kde eutils

DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="http://dev.gentoo.org/~squinky86/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="curl"

RDEPEND=">=app-text/sword-1.5.8_pre1
	>=net-misc/curl-7.10"
DEPEND=${RDEPEND}
need-kde 3

src_unpack() {
	unpack ${A}
	cd ${S}
	./autogen.sh
}

pkg_preinst() {
	if ! use curl ; then
		ewarn
		ewarn "You do not have \"curl\" support enabled in your USE variable."
		ewarn "This means SWORD may not have been compiled with curl support."
		ewarn "If you wish to use BibleTime's ability to download modules"
		ewarn "straight from the SWORD website, please add \"curl\" to your"
		ewarn "USE variable in /etc/make.conf or make sure app-text/sword was"
		ewarn "compiled with support for curl:"
		ewarn "  USE=\"curl\" emerge sword"
		ewarn "Press ctrl+c to abort the merge of BibleTime if you want to"
		ewarn "recompile SWORD with curl support."
		ewarn
		ebeep 5
		epause 8
	fi
}

pkg_postinst() {
	if use curl ; then
		einfo
		einfo "To use BibleTime's ability to install modules from"
		einfo "The SWORD Project's website, make sure that SWORD"
		einfo "was compiled with curl support, either by making"
		einfo "sure the \"curl\" USE flag is set in /etc/make.conf"
		einfo "or by installing SWORD with:"
		einfo "  USE=\"curl\" emerge sword"
		einfo
	fi
}
