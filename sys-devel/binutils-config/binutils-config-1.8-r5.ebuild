# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-config/binutils-config-1.8-r5.ebuild,v 1.1 2005/08/27 05:34:12 vapier Exp $

DESCRIPTION="Utility to change the binutils version being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="app-shells/bash"

src_install() {
	newbin "${FILESDIR}"/${PN}-${PV} ${PN} || die
	doman "${FILESDIR}"/${PN}.8
}
