# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usbmon/usbmon-4.ebuild,v 1.1 2007/04/01 00:23:49 robbat2 Exp $

DESCRIPTION="Userland for USB monitoring framework"
HOMEPAGE="http://people.redhat.com/zaitcev/linux/"
SRC_URI="${HOMEPAGE}/${P/-/.}.tar.gz"
LICENSE="as-is" # need to consult with upstream still
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""
DEPEND="!=sys-apps/usbutils-0.72-r2"
S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	sed -i -e '/CFLAGS =/s, = , \+= ,g' ${S}/Makefile
}

src_install() {
	dosbin usbmon
	doman usbmon.8
}
