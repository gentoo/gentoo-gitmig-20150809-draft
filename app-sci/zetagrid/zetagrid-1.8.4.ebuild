# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/zetagrid/zetagrid-1.8.4.ebuild,v 1.1 2003/04/13 22:33:28 tantive Exp $

S=${WORKDIR}/zetagrid-${PV}
DESCRIPTION="An open source and platform independent grid system"
SRC_URI="http://www.zetagrid.net/zeta/zeta_cmd_${PV}.zip http://www.zetagrid.net/zeta/add-ons/zeta_progress.zip"
HOMEPAGE="http://www.zetagrid.net http://cvs.gentoo.org/~tantive"
IUSE=""

DEPEND="virtual/glibc
	app-arch/unzip"
RDEPEND="virtual/jre
	>=sys-libs/lib-compat-1.1"
SLOT="0"
LICENSE="ZetaGrid"
KEYWORDS="x86 ppc sparc alpha"

src_unpack() {
	unpack zeta_cmd_${PV}.zip zeta_progress.zip
	if test -e /opt/zetagrid/zeta.cfg; then
	    cp /opt/zetagrid/zeta.cfg ${WORKDIR}/zeta.cfg
	fi
}

src_install() {
	dodir /opt/zetagrid
	cp ${FILESDIR}/zeta.sh ${D}/opt/zetagrid
	cp ${FILESDIR}/zeta_progress.sh ${D}/opt/zetagrid
	cp ${WORKDIR}/* ${D}/opt/zetagrid
	exeinto /etc/init.d
	newexe ${FILESDIR}/zetagrid.init zetagrid
}

pkg_postinst() {
	einfo "Zetagrid is now installed in /opt/zetagrid"
	einfo "Please change zeta.cfg for configuration issues!"
	einfo "More information about setup can be found at"
	einfo "http://cvs.gentoo.org/~tantive"
	einfo
	einfo "Zetagrid can be started using zeta.sh"
	einfo "Progress information is displayed by zeta_progress.sh or"
	einfo "by "java -cp zeta_progress.jar zeta.JShowProgress"."
	einfo
	ewarn "If you're getting an error at first execution"
	ewarn "please run it a second time, this issue is known"
	ewarn "and only happens at the very first start."
}

