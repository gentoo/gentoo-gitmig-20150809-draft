# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev/crossdev-0.9.1-r1.ebuild,v 1.1 2005/03/10 22:49:08 vapier Exp $

DESCRIPTION="Gentoo Cross-toolchain generator"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="sys-apps/portage
	app-shells/bash
	sys-apps/coreutils"

src_install() {
	dobin "${FILESDIR}"/crossdev || die
	dosed "s:GENTOO_PV:${PV}:" /usr/bin/crossdev
}
