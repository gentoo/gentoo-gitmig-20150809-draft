# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/groupuserfolder/groupuserfolder-3.2.ebuild,v 1.2 2005/04/02 08:54:45 blubb Exp $

inherit zproduct

DESCRIPTION="GroupUserFolder is a kind of user folder that provides a special kind of user management."
HOMEPAGE="http://ingeniweb.sourceforge.net/Products/GroupUserFolder/"
SRC_URI="mirror://sourceforge/collective/GroupUserFolder-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc ~sparc ~amd64"
IUSE=""

ZPROD_LIST="GroupUserFolder"

pkg_postinst()
{
	zproduct_pkg_postinst
	einfo
	einfo "Please note that using GRUF 3.* with Plone 2.0.* can result in errors."
	einfo "For more information please inspect documentation shown below"
	einfo "/usr/share/zproduct/groupuserfolder-${PV}/GroupUserFolder/README-Plone.stx"
	einfo
}
