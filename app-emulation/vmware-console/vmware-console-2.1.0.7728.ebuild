# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-console/vmware-console-2.1.0.7728.ebuild,v 1.2 2005/01/01 14:19:18 eradicator Exp $

MY_PN="VMware-console-2.1.0-7728.tar.gz"
S="${WORKDIR}/vmware-console-distrib"

DESCRIPTION="VMware Remote Console for Linux"
HOMEPAGE="http://www.vmware.com/"
SRC_URI="${MY_PN}"

LICENSE="vmware-console"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RESTRICT="fetch nostrip"

DEPEND="virtual/libc
	virtual/x11"

pkg_nofetch() {
	einfo "Please place ${FN} in ${DISTDIR}"
}

src_install() {
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
