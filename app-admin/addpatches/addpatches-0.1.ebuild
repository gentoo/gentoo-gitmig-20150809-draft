# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author: Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.1.ebuild,v 1.1 2002/06/16 14:24:47 lamer Exp $

# Short one-line description of this package.
DESCRIPTION="patch management script."

LICENSE="as-is"
RDEPEND="sys-devel/patch"
src_install () {
	dobin ${FILESDIR}/addpatches
}
