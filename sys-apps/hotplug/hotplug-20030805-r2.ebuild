# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20030805-r2.ebuild,v 1.3 2003/12/18 22:50:47 gmsoft Exp $

inherit eutils

# source maintainers named it hotplug-YYYY_MM_DD instead of hotplug-YYYYMMDD
MY_P=${PN}-${PV:0:4}_${PV:4:2}_${PV:6:2}
S=${WORKDIR}/${MY_P}
DESCRIPTION="USB and PCI hotplug scripts"
HOMEPAGE="http://linux-hotplug.sourceforge.net"
SRC_URI="mirror://sourceforge/linux-hotplug/${MY_P}.tar.gz
	mirror://gentoo/${P}-gentoo-patches.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc hppa ~sparc ~alpha ~mips ~arm ppc64"

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/pciutils-2.1.9 >=sys-apps/usbutils-0.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/hotplug-patches

	# The following patch prevents bogus messages of the flavor
	# "missing kernel or user mode driver prism2_usb".  It has been
	# mentioned on the linux-hotplug mailing list.
	epatch ${FILESDIR}/hotplug.functions.patch

	cd ${S}/etc/hotplug/
	cat ${FILESDIR}/usb.agent.diff | patch usb.agent || die
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
	doexe *.agent *.rc ${FILESDIR}/firmware.agent
	dodir /usr/lib/hotplug/firmware
	dodir /etc/hotplug/usb /etc/hotplug/pci
	cd ${S}/etc/hotplug.d/default
	exeinto /etc/hotplug.d/default
	doexe default.hotplug

	exeinto /etc/init.d
	newexe ${FILESDIR}/hotplug.rc hotplug

	insinto /etc/conf.d
	newins ${FILESDIR}/usb.confd usb
	dodir /var/run/usb
}

pkg_postinst() {
	ewarn "WARNING: The fxload program was spliced off this package"
	ewarn "WARNING: emerge fxload if you need it"
}

