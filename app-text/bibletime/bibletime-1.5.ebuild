# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.5.ebuild,v 1.1 2005/07/27 21:21:38 greg_g Exp $

inherit kde eutils

DESCRIPTION="KDE Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=app-text/sword-1.5.8"

need-kde 3

pkg_setup() {
	if ! built_with_use app-text/sword curl; then
		echo
		ewarn "The SWORD library may not have been compiled with curl support."
		ewarn "If you wish to use BibleTime's ability to download modules"
		ewarn "straight from the SWORD website, please make sure app-text/sword"
		ewarn "was compiled with USE=\"curl\"."
		ewarn "Press ctrl+c to abort the merge of BibleTime if you want to"
		ewarn "recompile SWORD with curl support."
		echo
		ebeep 5
	fi
}
