# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/openmosixview/openmosixview-1.5.ebuild,v 1.3 2004/10/26 15:01:06 tantive Exp $

S=${WORKDIR}/openmosixview-${PV}
DESCRIPTION="cluster-management GUI for OpenMosix"
SRC_URI="www.openmosixview.com/download/openmosixview-${PV}.tar.gz"
HOMEPAGE="http://www.openmosixview.com"
IUSE=""

DEPEND=">=x11-libs/qt-2.3.0
	>=sys-cluster/openmosix-user-0.3.0
	>=sys-kernel/openmosix-sources-2.4.19"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha"

src_unpack() {
	cd ${WORKDIR}
	unpack openmosixview-${PV}.tar.gz

	cat > configuration << EOF
	# test which version of qt is installed
	if [ -d /usr/qt/3 ]; then
		QTDIR=/usr/qt/3; else
		QTDIR=/usr/qt/2;
	fi
	CC=gcc
EOF
}

src_compile() {
	cd ${S}
	make
}

src_install() {
	dodir /usr/local/bin

	make BINDIR=${D}usr/local/bin INITDIR=${D}etc/init.d install || die

	dodoc COPYING README

	exeinto /etc/init.d
	rm ${D}/etc/init.d/openmosixcollector
	newexe ${FILESDIR}/openmosixcollector.init openmosixcollector
}

pkg_postinst() {
	einfo
	einfo "Openmosixview will allow you to monitor all nodes in your cluster."
	einfo
	einfo "You will need ssh to all cluster-nodes without password."
	einfo
	einfo "To setup your other nodes you will have to copy the"
	einfo "openmosixprocs binary onto each node"
	einfo "(scp /usr/local/bin/openmosixprocs your_node:/usr/local/bin/openmosixprocs)"
	einfo
	einfo "Start openmosixcollector"
	einfo "manually (/etc/init.d/openmosixcollector start) or"
	einfo "automatically using rc-update"
	einfo "(rc-update add openmosixcollector default)."
	einfo
	einfo "Run openmosixview by simply typing openmosixview."
	einfo
}
