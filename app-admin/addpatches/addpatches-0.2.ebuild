# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.2.ebuild,v 1.16 2004/03/08 03:12:22 tgall Exp $

DESCRIPTION="patch management script"
HOMEPAGE="http://www.gentoo.org"
DEPEND=""
IUSE=""
SRC_URI=""

SLOT="0"
LICENSE="as-is"
KEYWORDS="ia64 x86 ppc sparc alpha hppa mips amd64 ppc64"

RDEPEND="sys-devel/patch"

src_install() {
	dobin ${FILESDIR}/addpatches
}
