# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hotplug/hotplug-20040105.ebuild,v 1.2 2004/02/13 19:49:31 vapier Exp $

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
KEYWORDS="x86 ppc ~sparc ~mips ~alpha ~arm hppa ~amd64"

# hotplug needs pcimodules utility provided by pcitutils-2.1.9-r1
DEPEND=">=sys-apps/pciutils-2.1.9 >=sys-apps/usbutils-0.9"

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="patch" epatch ${WORKDIR}/hotplug-patches

	EPATCH_OPTS="${EPATCH_OPTS} ${S}/etc/hotplug/usb.agent" \
	epatch ${FILESDIR}/usb.agent.diff
	epatch ${FILESDIR}/kernel-26-fix.patch || die
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

