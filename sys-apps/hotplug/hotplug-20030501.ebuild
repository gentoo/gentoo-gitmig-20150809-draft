# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20030501.ebuild,v 1.1 2003/05/03 18:34:38 azarah Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="USB and PCI hotplug scripts"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz
	mirror://gentoo/${PN}-${PVR}-gentoo-patches.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~hppa"

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/pciutils-2.1.9
	>=sys-apps/usbutils-0.9"

src_unpack() {
	unpack ${A}

	cd ${S}/etc/hotplug
	epatch ${WORKDIR}/hotplug-patches/
}

src_install() {
	into /
	dosbin sbin/hotplug
	doman *.8
	dodoc README ChangeLog

	cd ${S}/etc/hotplug
	insinto /etc/hotplug
	doins blacklist hotplug.functions usb.distmap usb.handmap usb.usermap
	exeinto /etc/hotplug
	doexe *.agent *.rc
	dodir /etc/hotplug/usb /etc/hotplug/pci
	cd ${S}/etc/hotplug.d/default
	exeinto /etc/hotplug.d/default
	doexe default.hotplug

	exeinto /etc/init.d
	newexe ${FILESDIR}/hotplug.rc hotplug
	
	insinto /etc/conf.d
	newins ${FILESDIR}/usb.confd usb
}

pkg_postinst() {
	ewarn "WARNING: The fxload program was spliced off this package"
	ewarn "WARNING: emerge fxload if you need it"
}

