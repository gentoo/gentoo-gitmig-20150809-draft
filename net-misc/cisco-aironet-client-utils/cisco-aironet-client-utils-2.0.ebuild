# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-aironet-client-utils/cisco-aironet-client-utils-2.0.ebuild,v 1.5 2005/03/10 20:14:24 wolf31o2 Exp $

DESCRIPTION="Cisco Aironet Client Utilities"
HOMEPAGE="http://www.cisco.com/pcgi-bin/tablebuild.pl/aironet-utils-linux"
SRC_URI="Linux-ACU-Driver-v${PV}.tar.gz"

LICENSE="cisco"
SLOT=0
KEYWORDS="-* x86"
RESTRICT="fetch"
IUSE="pcmcia"

DEPEND="virtual/libc
	pcmcia? ( sys-apps/pcmcia-cs )"

RDEPEND="virtual/x11
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}/acu


pkg_nofetch() {
	eerror "Please goto:"
	eerror " ${HOMEPAGE}"
	eerror "and download"
	eerror " ${A}"
	eerror "to ${DISTDIR}"
}

src_unpack() {
	mkdir -p ${S}
	cd ${S}
	unpack ${A}
}

src_install() {
	exeinto /opt/cisco/bin
	doexe utilities/{acu,bcard,leap{set,script,login}}

	insinto /opt/cisco
	doins ACU.PRFS
	chmod a+rw ${D}/opt/cisco/ACU.PRFS

	doins helpml.tar.gz
	pushd ${D}/opt/cisco > /dev/null
	tar zxf helpml.tar.gz
	rm -f helpml.tar.gz
	popd > /dev/null

	insinto /etc/env.d
	doins ${FILESDIR}/90cisco
}
