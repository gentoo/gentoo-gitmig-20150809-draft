# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20020401.ebuild,v 1.4 2002/08/11 13:22:59 phoenix Exp $

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=`echo ${P}|sed 's/-\(....\)\(..\)\(..\)/-\1_\2_\3/'`
S=${WORKDIR}/${MY_P}
DESCRIPTION="USB and PCI hotplug scripts"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/linux-hotplug/${MY_P}.tar.gz"
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

	cd ${S}/etc/hotplug
	patch -p0 < ${FILESDIR}/${P}-pci.rc-gentoo.diff
	patch -p0 < ${FILESDIR}/${P}-usb.rc-gentoo.diff
}

src_install () {
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

	exeinto /etc/init.d
	newexe ${FILESDIR}/hotplug.rc hotplug
	
	insinto /etc/conf.d
	newins ${FILESDIR}/usb.conf usb
}

pkg_postinst () {
	einfo WARNING: The fxload program was spliced off this package.
	einfo WARNING: emerge fxload if you need it.
}
