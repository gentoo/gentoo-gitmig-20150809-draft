# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zprod-update/zprod-update-0.1.ebuild,v 1.3 2003/06/29 15:24:08 aliz Exp $

DESCRIPTION="Gentoo Zope Product selection tool."
SRC_URI=""
HOMEPAGE=""
IUSE=""
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
 
DEPEND=">=dev-util/dialog-0.7
        sys-apps/grep
        sys-apps/sed
		>=net-zope/zope-2.6.0-r2"
 
src_install() {
        dosbin ${FILESDIR}/${PV}/zprod-update
}
