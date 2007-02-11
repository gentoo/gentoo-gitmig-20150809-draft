# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/addpatches/addpatches-0.2.ebuild,v 1.22 2007/02/11 13:08:09 vapier Exp $

DESCRIPTION="patch management script"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""

src_install() {
	dobin "${FILESDIR}"/addpatches || die
}
