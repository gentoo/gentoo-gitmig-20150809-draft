# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp-core/ltsp-core-4.1-r1.ebuild,v 1.1 2004/09/08 16:06:45 lanius Exp $

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
KEYWORDS="~x86"

S=${WORKDIR}/ltsp

LTSP_CORE="ltsp-ltsptree-1.7-0-i386.tgz
ltsp-glibc-1.0-0-i386.tgz
ltsp-sysvinit-1.0-0-i386.tgz
ltsp-popt-1.1-0-i386.tgz
ltsp-bash-1.0-0-i386.tgz
ltsp-busybox-1.0-0-i386.tgz
ltsp-devfsd-1.0-0-i386.tgz
ltsp-getltscfg-1.2-0-i386.tgz
ltsp-libgcc_s-1.0-0-i386.tgz
ltsp-haltsys-1.0-0-i386.tgz
ltsp-e2fsprogs-1.1-0-i386.tgz
ltsp-startsess-1.1-0-i386.tgz
ltsp-lp_server-1.1-0-i386.tgz
ltsp-ltspinfod-1.1-0-i386.tgz
ltsp-modutils-1.0-0-i386.tgz
ltsp-ncurses-1.0-0-i386.tgz
ltsp-open-1.1-0-i386.tgz
ltsp-prep_swap-1.0-0-i386.tgz
ltsp-zlib-1.0-0-i386.tgz
ltsp-libpng-1.0-0-i386.tgz
ltsp-pci_scan-1.0-0-i386.tgz
ltsp-pam-1.0-0-i386.tgz
ltsp-ssh-1.0-0-i386.tgz
ltsp-net-tools-1.0-0-i386.tgz
ltsp-xinetd-1.0-0-i386.tgz
ltsp-ypbind-1.0-0-i386.tgz
ltsp-tcp_wrappers-1.0-0-i386.tgz
ltsp-portmap-1.0-0-i386.tgz
ltsp-rdesktop-1.3-0-i386.tgz
ltsp-libvncserver-1.0-0-i386.tgz
ltsp-localdev-1.1-0-i386.tgz
ltsp-openssl-1.0-0-i386.tgz
ltsp-samba-1.0-0-i386.tgz
ltsp-util-linux-1.0-0-i386.tgz
ltsp-vidlist-1.1-0-i386.tgz
ltsp-aumix-1.0-0-i386.tgz
ltsp-freetype-1.0-0-i386.tgz"

use snmp && LTSP_CORE="${LTSP_CORE} ltsp-snmpd-1-0-i386.tgz"

LTSP_DEBUG="ltsp-gdb-1.0-0-i386.tgz
ltsp-strace-1.0-0-i386.tgz"

LTSP_X="ltsp-x-core-1.2-0-i386.tgz
ltsp-x-fonts-1.0-0-i386.tgz
ltsp-x-fonts-100dpi-1.0-0-i386.tgz
ltsp-x336_3DLabs-1.0-0-i386.tgz
ltsp-x336_8514-1.0-0-i386.tgz
ltsp-x336_AGX-1.0-0-i386.tgz
ltsp-x336_I128-1.0-0-i386.tgz
ltsp-x336_Mach32-1.0-0-i386.tgz
ltsp-x336_Mach64-1.0-0-i386.tgz
ltsp-x336_Mach8-1.0-0-i386.tgz
ltsp-x336_Mono-1.0-0-i386.tgz
ltsp-x336_P9000-1.0-0-i386.tgz
ltsp-x336_S3_S3V-1.0-0-i386.tgz
ltsp-x336_SVGA-1.0-0-i386.tgz
ltsp-x336_VGA16-1.0-0-i386.tgz
ltsp-x336_W32-1.0-0-i386.tgz"

LTSP_STUFF="ltsp-kernel-1.4-0-i386.tgz
ltsp-modules-1.4-0-i386.tgz"

LTSP_UTILS="ltsp-utils-0.9.tgz"

KERNEL_VERSION="2.4.26-ltsp-2"

use audiofile && LTSP_SOUND="${LTSP_SOUND} ltsp-audiofile-1.0-0-i386.tgz"
use esd && LTSP_SOUND="${LTSP_SOUND} ltsp-esd-1.0-0-i386.tgz"
use nas && LTSP_SOUND="${LTSP_SOUND} ltsp_nasd-1.1-0-i386.tgz"

for FILE in ${LTSP_CORE} ${LTSP_STUFF}
do
	SRC_URI="${SRC_URI} http://www.ltsp.org/ltsp-4.1/${FILE}"
done

for FILE in ${LTSP_DEBUG}
do
	SRC_URI="${SRC_URI} debug? ( http://www.ltsp.org/ltsp-4.1/${FILE} )"
done

for FILE in ${LTSP_X}
do
	SRC_URI="${SRC_URI} X? ( http://www.ltsp.org/ltsp-4.1/${FILE} )"
done

for FILE in ${LTSP_SOUND}
do
	SRC_URI="${SRC_URI} http://www.ltsp.org/ltsp-4.1/${FILE}"
done

SRC_URI="${SRC_URI} mirror://sourceforge/ltsp/${LTSP_UTILS}"


src_unpack() {
	# nothing to unpack
	mkdir ltsp
	cd ltsp

	for FILE in ${LTSP_STUFF} ${LTSP_UTILS}
	do
		tar -xzf ${DISTDIR}/${FILE}
	done
}

src_install() {
	# now unpack the files
	# first the core stuff
	dodir /opt/ltsp-${PV}
	echo "Installing core packages..."
	for FILE in ${LTSP_CORE}
	do
		tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp-${PV} 2> /dev/null
	done

	# debug stuff
	if use debug ; then
		echo "Installing debug packages..."
		for FILE in ${LTSP_DEBUG}
		do
			tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp-${PV} 2> /dev/null
		done
	fi

	# X stuff
	if use X ; then
		echo "Installing X packages..."
		for FILE in ${LTSP_X}
		do
			tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp-${PV} 2> /dev/null
		done
	fi

	# kernel stuff
	echo "Installing kernel packages..."
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
	echo "Doing several other stuff..."
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
