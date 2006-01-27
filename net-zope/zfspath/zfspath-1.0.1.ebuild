# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zfspath/zfspath-1.0.1.ebuild,v 1.4 2006/01/27 02:50:50 vapier Exp $

inherit zproduct

DESCRIPTION="Zope product to allow access to the filesystem"
HOMEPAGE="http://zope.org/Members/asterisk/ZFSPath/"
SRC_URI="http://zope.org/Members/asterisk/ZFSPath/${PV}/ZFSPath-${PV}.tgz"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

RDEPEND=">=net-zope/zope-2.6.4"

ZPROD_LIST="ZFSPath"

pkg_postinst() {
	zproduct_pkg_postinst
	einfo "Please view this product documentation through the ZMI for usage instructions."
}
