# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp/ltsp-4.1-r1.ebuild,v 1.4 2004/12/05 11:17:14 lanius Exp $

IUSE="X debug nas esd audiofile snmp"

DESCRIPTION="LTSP - Linux Terminal Server Project"
HOMEPAGE="http://www.ltsp.org/"

DEPEND="app-arch/tar
	virtual/gzip"

RDEPEND="X? ( virtual/x11 )
	virtual/tftp
	sys-apps/xinetd
	net-misc/dhcp
	net-fs/nfs-utils
	net-nds/portmap"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

SRC_URI="
http://www.ltsp.org/ltsp-4.1/ltsp-ltsptree-1.7-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-glibc-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-sysvinit-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-popt-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-bash-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-busybox-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-devfsd-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-getltscfg-1.2-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-libgcc_s-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-haltsys-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-e2fsprogs-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-startsess-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-lp_server-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-ltspinfod-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-modutils-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-ncurses-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-open-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-prep_swap-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-zlib-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-libpng-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-pci_scan-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-pam-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-ssh-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-net-tools-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-xinetd-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-ypbind-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-tcp_wrappers-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-portmap-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-rdesktop-1.3-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-libvncserver-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-localdev-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-openssl-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-samba-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-util-linux-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-vidlist-1.1-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-aumix-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-freetype-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-kernel-1.4-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-modules-1.4-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-utils-0.9.tgz

snmp? (
http://www.ltsp.org/ltsp-4.1/http://www.ltsp.org/ltsp-4.1/ltsp-snmpd-1-0-i386.tgz )

debug? (
http://www.ltsp.org/ltsp-4.1/ltsp-gdb-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-strace-1.0-0-i386.tgz )

X? (
http://www.ltsp.org/ltsp-4.1/ltsp-x-core-1.2-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x-fonts-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x-fonts-100dpi-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_3DLabs-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_8514-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_AGX-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_I128-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_Mach32-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_Mach64-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_Mach8-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_Mono-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_P9000-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_S3_S3V-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_SVGA-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_VGA16-1.0-0-i386.tgz
http://www.ltsp.org/ltsp-4.1/ltsp-x336_W32-1.0-0-i386.tgz )

audiofile? (
http://www.ltsp.org/ltsp-4.1/ltsp-audiofile-1.0-0-i386.tgz )

esd? (
http://www.ltsp.org/ltsp-4.1/ltsp-esd-1.0-0-i386.tgz )

nas? (
http://www.ltsp.org/ltsp-4.1/ltsp_nasd-1.1-0-i386.tgz )"

S=${WORKDIR}/ltsp

KERNEL_VERSION="2.4.26-ltsp-2"

src_unpack() {
	# nothing to unpack
	mkdir ltsp
	cd ltsp

	unpack ltsp-utils-0.9.tgz
	unpack ltsp-kernel-1.4-0-i386.tgz
	unpack ltsp-modules-1.4-0-i386.tgz
}

src_install() {
	# core packages
	MY_A=${A/ltsp-utils-0.9.tgz/}
	MY_A=${MY_A/ltsp-kernel-1.4-0-i386.tgz/}
	MY_A=${MY_A/ltsp-modules-1.4-0-i386.tgz/}

	dodir /opt/ltsp-${PV}
	cd ${D}/opt/ltsp-${PV}
	unpack ${MY_A}

	# kernel stuff
	cd ${S}
	find i386 -print | cpio -pmud --quiet ${D}/opt/ltsp-${PV} 2> /dev/null
	insinto /tftpboot/lts
	doins vmlinuz-${KERNEL_VERSION}

	# pxe stuff
	insinto /tftpboot/pxe
	doins ${FILESDIR}/eb-5.0.9-rtl8139.lzpxe
	doins ${FILESDIR}/eb-5.0.9-eepro100.lzpxe
	doins ${FILESDIR}/eb-5.0.9-3c905c-tpo.lzpxe

	# config stuff
	cd ltsp-utils
	dosbin ltspcfg
	dosbin ltspinfo
	dosbin ltspadmin
	dodoc COPYING
	cd ..

	# several other stuff
	rm -fR ${D}/usr/share/
}

pkg_postinst() {
	einfo
	einfo "Either use ltspcfg to configure your stuff, or follow the guide at gentoo.org:"
	einfo "                   http://www.gentoo.org/doc/en/ltsp.xml                      "
	einfo
}
