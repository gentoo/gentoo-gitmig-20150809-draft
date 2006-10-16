# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp/ltsp-4.2.ebuild,v 1.1 2006/10/16 21:37:24 genstef Exp $

inherit eutils

IUSE="X debug nas esd audiofile snmp sane rdesktop vnc"

LTSP_KERNEL_VER="2.6.17.8-ltsp-1"

DESCRIPTION="LTSP - Linux Terminal Server Project"
HOMEPAGE="http://www.ltsp.org/"

DEPEND="app-arch/tar
	virtual/gzip"

RDEPEND="virtual/tftp
	sys-apps/xinetd
	|| ( net-misc/dhcp net-dns/dnsmasq )
	net-fs/nfs-utils
	net-nds/portmap
	dev-perl/libwww-perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"

SRC_URI="
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-kernel-${LTSP_KERNEL_VER}-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-modules-${LTSP_KERNEL_VER}-0-i386.tgz

http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-aumix-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-bash-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-busybox-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-e2fsprogs-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-freetype-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-getltscfg-1.3-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-glibc-1.0-1-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-haltsys-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-lbuscd-0.6-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-libgcc_s-1.0-1-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-libpng-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-libusb-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-localdev-1.3-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-lp_server-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ltspfsd-0.5-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ltspinfod-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ltsptree-1.17-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-module-init-tools-3.3-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-nbd-1.0-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ncurses-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-net-tools-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-nfs-utils-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-open-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-openssl-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-pam-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-pci_scan-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-pciutils-1.0-1-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-perl-1.0-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-popt-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-portmap-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-prep_swap-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ssh-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-startsess-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-sysvinit-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-tcp_wrappers-1.1-0-i386.tgz

http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-udev-1.0-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-udev-rules-1.5-0-i386.tgz

http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-util-linux-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-vidlist-1.6-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-xinetd-1.2-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-ypbind-1.1-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-zlib-1.0-1-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/utils/ltsp-utils-0.25-0.tgz

sane? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-sane-1.4-1-i386.tgz )

vnc? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-vnc-module-1.0-0-i386.tgz 
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-libvncserver-1.1-0-i386.tgz )

rdesktop? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-rdesktop-1.8-0-i386.tgz )

snmp? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-snmpd-1.1-0-i386.tgz )

debug? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-gdb-1.1-0-i386.tgz )

X? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-x-core-1.6-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-x-fonts-100dpi-1.6-0-i386.tgz
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-x-fonts-1.6-0-i386.tgz )

audiofile? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-audiofile-1.1-0-i386.tgz )

esd? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp-esd-1.2-0-i386.tgz )

nas? (
http://ltsp.mirrors.tds.net/pub/ltsp/ltsp-4.2/ltsp_nasd-1.2-0-i386.tgz )"

S=${WORKDIR}/ltsp

src_unpack() {
	# nothing to unpack
	mkdir ltsp
	cd ltsp

	unpack ltsp-utils-0.25-0.tgz
	unpack ltsp-kernel-${LTSP_KERNEL_VER}-0-i386.tgz
	unpack ltsp-modules-${LTSP_KERNEL_VER}-0-i386.tgz
}

src_install() {

	# core packages
	MY_A=${A/ltsp-utils-0.25-0.tgz/}
	MY_A=${MY_A/ltsp-kernel-${LTSP_KERNEL_VER}.0-i386.tgz/}
	MY_A=${MY_A/ltsp-modules-${LTSP_KERNEL_VER}.0-i386.tgz/}

	dodir /opt/ltsp-${PV}
	cd ${D}/opt/ltsp-${PV}
	unpack ${MY_A}

	# kernel stuff
	cd ${S}
	find i386 -print | cpio -pmud --quiet ${D}/opt/ltsp-${PV} 2> /dev/null
	insinto /tftpboot/lts
	doins vmlinuz-${LTSP_KERNEL_VER}

	# pxe stuff
	insinto /tftpboot/pxe
	doins ${LTSP_KERNEL_VER}/pxelinux.0

	# pxe default config
	insinto /tftpboot/pxelinux.cfg
	doins ${LTSP_KERNEL_VER}/pxelinux.cfg/default

	insinto /tftpboot/pxe
	doins ${LTSP_KERNEL_VER}/initramfs.gz
	doins ${LTSP_KERNEL_VER}/bzImage-${LTSP_KERNEL_VER}

	insinto /tftpboot/pxe
	doins ${FILESDIR}/eb-5.0.9-rtl8139.lzpxe
	doins ${FILESDIR}/eb-5.0.9-eepro100.lzpxe
	doins ${FILESDIR}/eb-5.0.9-3c905c-tpo.lzpxe

	# config stuff
	cd ltsp-utils
	dosbin ltspcfg
	dodir /etc
	echo "LTSP_DIR=/opt/ltsp-${PV}" > ${D}/etc/ltsp.conf
	dosbin ltspinfo
	dosbin ltspadmin
	dodoc COPYING
	cd ..

	# several other stuff
	rm -fR ${D}/usr/share/
	rm -fR ${D}/opt/ltsp-${PV}/i386/usr/share/aclocal
}

pkg_postinst() {
	einfo
	einfo "Either use ltspcfg to configure your stuff, or follow the guide at gentoo.org:"
	einfo "                   http://www.gentoo.org/doc/en/ltsp.xml"
	einfo
	einfo "     NOTE: The directory containing LTSP has changed to /opt/ltsp-4.2/"
	einfo
}

