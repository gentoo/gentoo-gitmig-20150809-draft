# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-config/binutils-config-1.0.ebuild,v 1.2 2004/11/14 08:51:33 vapier Exp $

DESCRIPTION="Utility to change the gcc compiler being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
IUSE=""

DEPEND="app-shells/bash"

src_install() {
	newbin ${FILESDIR}/${PN}-${PV} ${PN} || die
	dosed "s:PORTAGE-VERSION:${PV}:" /usr/bin/${PN}
}
