
# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/zope-config/zope-config-0.1-r1.ebuild,v 1.4 2003/04/24 17:08:57 weeve Exp $

DESCRIPTION="A Gentoo Zope multi-Instance configure tool."
SRC_URI=""
HOMEPAGE=""
IUSE=""
 
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc"
 
DEPEND=""
RDEPEND=">=dev-util/dialog-0.7
    sys-apps/grep
    sys-apps/sed
	>=net-zope/zope-2.6.0-r2"
 
src_install() {
        dosbin ${FILESDIR}/${PV}/zope-config
}
