# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.2.ebuild,v 1.8 2003/02/27 18:10:47 zwelch Exp $

DESCRIPTION="patch management script"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ppc sparc alpha hppa arm"

RDEPEND="sys-devel/patch"

src_install() {
	dobin ${FILESDIR}/addpatches
}
