# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/emool/emool-0.10.ebuild,v 1.2 2006/05/01 08:13:23 blubb Exp $

DESCRIPTION="emool is a tool used to automatically generate emul-packages"
HOMEPAGE="http://www.blubb.ch/emool/"
SRC_URI="http://www.blubb.ch/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	dosbin src/emool src/emool-inside
	insinto /etc/emool/
	doins src/emool.conf
	keepdir /etc/emool/portage

	doman src/emool.1
	dodoc ChangeLog TODO AUTHORS
}
