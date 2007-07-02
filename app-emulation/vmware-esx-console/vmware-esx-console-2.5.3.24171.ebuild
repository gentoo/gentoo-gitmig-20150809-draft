# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/vmware-esx-console/vmware-esx-console-2.5.3.24171.ebuild,v 1.3 2007/07/02 14:03:32 peper Exp $

MY_PN="VMware-console-2.5.3-24171.tar.gz"
S="${WORKDIR}/vmware-console-distrib"

DESCRIPTION="VMware ESX Remote Console for Linux"
HOMEPAGE="http://www.vmware.com/"
SRC_URI="${MY_PN}"

LICENSE="vmware-console"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="fetch strip"

DEPEND="virtual/libc"

RDEPEND="|| ( ( x11-libs/gtk+
		 	    x11-libs/libICE
		 	    x11-libs/libSM
		 	    x11-libs/libXext
		 		x11-libs/libXi
		 		x11-libs/libXpm
		 		x11-libs/libXtst
		 		x11-libs/libX11 )
			  virtual/x11 )
		 sys-libs/zlib"

pkg_nofetch() {
	einfo "Please place ${FN} in ${DISTDIR}"
}

src_install() {
	dodir /opt/vmware-console-distrib
	cp -pPR ${S}/* ${D}/opt/vmware-console-distrib
	dodir /usr/bin
	dosym /opt/vmware-console-distrib/bin/vmware-console /usr/bin/vmware-console
	dosym /opt/vmware-console-distrib/bin/vmware-config-console.pl /usr/bin/vmware-config-console.pl
	dosym /opt/vmware-console-distrib/lib /usr/lib/vmware-console
	dosym /opt/vmware-console-distrib/doc /usr/share/doc/vmware-console
}

pkg_postinst() {

	elog "Before running VMware Remote Console for the first time, you need
		to configure it by invoking the following command:
		/usr/bin/vmware-config-console.pl "
}

