# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/webcomics-collector/webcomics-collector-0.7.1.ebuild,v 1.1 2004/09/14 23:15:01 vapier Exp $

inherit distutils

DESCRIPTION="python script for downloading webcomics"
HOMEPAGE="http://collector.skumleren.net/"
SRC_URI="http://collector.skumleren.net/releases/collector-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

S=${WORKDIR}/collector-${PV}

pkg_postinst() {
	ewarn "If you have comic archives with any comics of type 'lateststatic',"
	ewarn "you have to use the tool fix_lateststatic.py to make them work"
	ewarn "with ${P}"
	ewarn "Also note that the definition format has changed, any custom defs"
	ewarn "you have will need updating. See the documentation for further info."
}
