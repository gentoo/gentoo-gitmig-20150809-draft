# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.1.ebuild,v 1.4 2002/07/29 03:51:12 cselkirk Exp $

# Short one-line description of this package.
DESCRIPTION="patch management script."

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc"

RDEPEND="sys-devel/patch"
src_install () {
	dobin ${FILESDIR}/addpatches
}
