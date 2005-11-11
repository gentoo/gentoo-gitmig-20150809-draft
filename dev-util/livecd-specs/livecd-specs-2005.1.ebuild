# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/livecd-specs/livecd-specs-2005.1.ebuild,v 1.1 2005/11/11 17:07:46 wolf31o2 Exp $

DESCRIPTION="Gentoo Linux official release spec files"
HOMEPAGE="http://www.gentoo.org/proj/en/releng/catalyst"
SRC_URI="http://dev.gentoo.org/~wolf31o2/sources/livecd-specs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	insinto /usr/share/${PF}
	doins -r ${S}/*
}
