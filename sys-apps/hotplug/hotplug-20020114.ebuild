# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20020114.ebuild,v 1.4 2002/07/14 19:20:18 aliz Exp $

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
S=${WORKDIR}/${P}
DESCRIPTION="USB hotplug utilities"
SRC_URI="mirror://sourceforge/linux-hotplug/hotplug-2002_01_14.tar.gz"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND="virtual/glibc
        >=sys-apps/pciutils-2.1.9
        >=sys-apps/usbutils-0.9"

src_unpack () {
	unpack ${A}

	# move it to dir which matches ebuild name
	mv ${WORKDIR}/hotplug-2002_01_14 ${S}

	# replace scripts which have redhat specific stuff
	cp ${FILESDIR}/pci.rc ${S}/etc/hotplug/pci.rc
	cp ${FILESDIR}/usb.rc ${S}/etc/hotplug/usb.rc
}

src_compile() {

	# compile fxload program
	make PREFIX="" all || die

}

src_install () {
	into /
	dosbin sbin/hotplug
	doman *.8
	dodoc README ChangeLog Makefile mkinstalldirs hotplug.spec	

	# fxload usb firmware downloader
	cd ${S}/fxload
	doman *.8
	docinto fxload
	dodoc README.txt Makefile

	cd ${S}/etc/hotplug
	insinto /etc/hotplug
	doins *
	exeinto /etc/hotplug
	doexe *.agent

	newexe ${FILESDIR}/pci.rc pci.rc
	newexe ${FILESDIR}/usb.rc usb.rc
	exeinto /etc/init.d
	newexe ${FILESDIR}/hotplug.rc hotplug
}
