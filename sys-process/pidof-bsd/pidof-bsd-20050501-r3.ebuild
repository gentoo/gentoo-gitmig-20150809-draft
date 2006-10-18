# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/pidof-bsd/pidof-bsd-20050501-r3.ebuild,v 1.2 2006/10/18 11:23:38 uberlord Exp $

inherit base bsdmk

DESCRIPTION="pidof(1) utility for *BSD"
HOMEPAGE="http://people.freebsd.org/~novel/pidof.html"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~sparc-fbsd ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="!sys-process/psmisc"

S="${WORKDIR}/pidof"

PATCHES="${FILESDIR}/${P}-gfbsd.patch
	${FILESDIR}/${P}-firstarg.patch
	${FILESDIR}/${P}-pname.patch"

src_install() {
	into /
	dobin pidof
}

