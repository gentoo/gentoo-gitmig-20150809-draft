# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cisco-aironet-client-utils/cisco-aironet-client-utils-2.1.ebuild,v 1.6 2005/03/10 20:14:24 wolf31o2 Exp $

DESCRIPTION="Cisco Aironet Client Utilities"
HOMEPAGE="http://www.cisco.com/pcgi-bin/tablebuild.pl/aironet-utils-linux"
SRC_URI="linux-acu-driver-v21.tar.gz"

LICENSE="cisco"
SLOT=0
KEYWORDS="-* x86"
RESTRICT="fetch"
IUSE="pcmcia"

DEPEND="virtual/libc
	pcmcia? ( sys-apps/pcmcia-cs )"

RDEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	<=dev-cpp/gtkmm-2.0"

S=${WORKDIR}


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
	pwd
	exeinto /opt/cisco/bin
	doexe linux/utilities/redhat90/{acu,bcard,leap{set,script,login}} \
		|| die "Copying binaries"

	insinto /opt/cisco
	doins linux/ACU.PRFS || die "Copying defaults"
	chmod a+rw ${D}/opt/cisco/ACU.PRFS || die "Making defaults writable"

	doins linux/helpml.tar.gz
	pushd ${D}/opt/cisco > /dev/null
	tar zxf helpml.tar.gz
	rm -f helpml.tar.gz
	popd > /dev/null

	insinto /etc/env.d
	doins ${FILESDIR}/90cisco
}
