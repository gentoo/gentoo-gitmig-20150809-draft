# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.2.ebuild,v 1.17 2004/04/14 18:09:32 randy Exp $

DESCRIPTION="patch management script"
HOMEPAGE="http://www.gentoo.org"
DEPEND=""
IUSE=""
SRC_URI=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="ia64 x86 ppc sparc alpha hppa mips amd64 ppc64 s390"

RDEPEND="sys-devel/patch"

src_install() {
	dobin ${FILESDIR}/addpatches
}
