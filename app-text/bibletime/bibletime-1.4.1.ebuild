# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.4.1.ebuild,v 1.2 2004/04/09 18:30:54 squinky86 Exp $

inherit kde
need-kde 3

IUSE="curl"
DESCRIPTION="BibleTime KDE Bible study application using the SWORD library."
HOMEPAGE="http://bibletime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
newdepend ">=app-text/sword-1.5.7
	>=net-misc/curl-7.10"

pkg_preinst() {
	if [ ! "`use curl`" ] ; then
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
		for TICKER in 1 2 3 4 5; do
			echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
			echo -ne "\a" ; sleep 1
		done
		sleep 8
	fi
}

pkg_postinst() {
	if [ `use curl` ] ; then
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
