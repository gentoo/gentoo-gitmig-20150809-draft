# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zprod-update/zprod-update-0.1.ebuild,v 1.1 2003/02/17 03:05:14 kutsuya Exp $

DESCRIPTION="Gentoo Zope Product selection tool."
SRC_URI=""
HOMEPAGE=""
IUSE=""
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
 
DEPEND=">=dev-util/dialog-0.7
        sys-apps/grep
        sys-apps/sed"
 
src_install() {
        dosbin ${FILESDIR}/${PV}/zprod-update
}
