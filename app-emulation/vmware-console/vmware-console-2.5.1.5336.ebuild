# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-console/vmware-console-2.5.1.5336.ebuild,v 1.1 2004/04/09 23:12:22 wolf31o2 Exp $

MY_PN="VMware-console-2.5.1-5336.tar.gz"
S="${WORKDIR}/vmware-console-distrib"

DESCRIPTION="VMware Remote Console for Linux"
HOMEPAGE="http://www.vmware.com/"
SRC_URI="${MY_PN}"

LICENSE="vmware-console"
SLOT="0"
KEYWORDS="~x86"
RESTRICT="fetch nostrip"
IUSE=""

DEPEND="virtual/glibc
	virtual/x11"

pkg_nofetch() {
	einfo "Please place ${FN} in ${DISTDIR}"
}

src_install () {
	dodir /opt/vmware/bin
	cp -a bin/* ${D}/opt/vmware/bin/

	dodir /opt/vmware/lib
	cp -dr lib/* ${D}/opt/vmware/lib/

	dodir /opt/vmware/doc
	cp -a doc/* ${D}/opt/vmware/doc/

	dodir /opt/vmware/man/
	cp -a man/* ${D}/opt/vmware/man/

	dodir /usr/bin
	dosym /opt/vmware/bin/vmware-console /usr/bin/vmware-console

	dodir /usr/lib
	dosym /opt/vmware/lib /usr/lib/vmware
}
