# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20020114.ebuild,v 1.13 2003/06/21 21:19:39 drobbins Exp $

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="USB hotplug utilities"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz
	mirror://gentoo/${PN}-gentoo-conf.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc"

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/pciutils-2.1.9
	>=sys-apps/usbutils-0.9"

src_unpack() {
	unpack ${A}

	# replace scripts which have redhat specific stuff
	cp ${WORKDIR}/hotplug-conf/pci.rc ${S}/etc/hotplug/pci.rc
	cp ${WORKDIR}/hotplug-conf/usb.rc ${S}/etc/hotplug/usb.rc
}

src_compile() {
	# compile fxload program
	make PREFIX="" all || die
}

src_install() {
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

	newexe ${WORKDIR}/hotplug-conf/pci.rc pci.rc
	newexe ${WORKDIR}/hotplug-conf/usb.rc usb.rc
	exeinto /etc/init.d
	newexe ${WORKDIR}/hotplug-conf/hotplug.rc hotplug
}
