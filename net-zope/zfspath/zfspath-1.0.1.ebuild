# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zfspath/zfspath-1.0.1.ebuild,v 1.2 2004/09/25 21:19:10 radek Exp $

inherit zproduct

DESCRIPTION="Zope product to allow access to the filesystem."
HOMEPAGE="http://zope.org/Members/asterisk/ZFSPath/"
SRC_URI="http://zope.org/Members/asterisk/ZFSPath/${PV}/ZFSPath-${PV}.tgz"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""
RDEPEND=">=net-zope/zope-2.6.4
	    ${RDEPEND}"

ZPROD_LIST="ZFSPath"

pkg_postinst()
{
	zproduct_pkg_postinst
	einfo "Please view this product documentation through the ZMI for usage instructions."
}
