# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/zetagrid/zetagrid-1.0.ebuild,v 1.6 2003/02/28 17:04:55 liquidx Exp $

S=${WORKDIR}/zetagrid-${PV}
DESCRIPTION="An open source and platform independent grid system"
SRC_URI="http://www.zetagrid.net/zeta/zeta_base.zip http://www.zetagrid.net/zeta/linux/zeta_linux_x86.zip http://www.zetagrid.net/zeta/add-ons/zeta_progress.zip"
HOMEPAGE="http://www.zetagrid.net"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="virtual/jre"

SLOT="0"
LICENSE="ZetaGrid"
KEYWORDS="x86"

src_unpack() {
	unpack zeta_base.zip zeta_linux_x86.zip zeta_progress.zip
}

src_install() {
	dodir /opt/zetagrid
	cp ${FILESDIR}/zeta.sh ${D}/opt/zetagrid
	cp ${FILESDIR}/zeta_progress.sh ${D}/opt/zetagrid
	cp ${WORKDIR}/* ${D}/opt/zetagrid
}

pkg_postinstl() {
	einfo "Zetagrid is now installed in /opt/zetagrid"
	einfo "Please change zeta.cfg for configuration issues!"
	einfo
	einfo "Zetagrid can be started using zeta.sh"
	einfo "Progress information is displayed by zeta_progress.sh or"
	einfo "by "java -cp zeta_progress.jar zeta.JShowProgress"."
}

