# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.2.ebuild,v 1.20 2005/01/01 10:53:48 eradicator Exp $

DESCRIPTION="patch management script"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE=""

DEPEND=""
RDEPEND="sys-devel/patch"

src_install() {
	dobin ${FILESDIR}/addpatches || die
}
