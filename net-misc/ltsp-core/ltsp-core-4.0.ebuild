# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp-core/ltsp-core-4.0.ebuild,v 1.1 2004/01/17 20:40:43 lanius Exp $

IUSE="X debug"

DESCRIPTION="LTSP - Linux Terminal Server Project"
HOMEPAGE="http://www.ltsp.org/"

LTSP_CORE="ltsp-ltsptree-0.09-0-i386.tgz
ltsp-glibc-2.3.2-0-i386.tgz
ltsp-sysvinit-2.84-0-i386.tgz
ltsp-popt-1.0-0-i386.tgz
ltsp-bash-2.05b-0-i386.tgz
ltsp-busybox-0.60.4-0-i386.tgz
ltsp-devfsd-1.3.25-0-i386.tgz
ltsp-getltscfg-0.02-0-i386.tgz
ltsp-libgcc_s-3.2.3-0-i386.tgz
ltsp-haltsys-0.02-0-i386.tgz
ltsp-e2fsprogs-1.29-0-i386.tgz
ltsp-startsess-1.1-0-i386.tgz
ltsp-lp_server-1.1.6-0-i386.tgz
ltsp-ltspinfod-0.1-0-i386.tgz
ltsp-modutils-2.4.22-0-i386.tgz
ltsp-ncurses-5.3-0-i386.tgz
ltsp-open-1.4-0-i386.tgz
ltsp-prep_swap-0.01-0-i386.tgz
ltsp-zlib-1.1.4-0-i386.tgz
ltsp-libpng-1.2.5-0-i386.tgz
ltsp-pci_scan-0.02-0-i386.tgz
ltsp-pam-0.77-0-i386.tgz
ltsp-ssh-3.7.1p2-0-i386.tgz
ltsp-audiofile-0.2.3-0-i386.tgz
ltsp-esd-0.2.32-0-i386.tgz
ltsp-net-tools-1.60-0-i386.tgz
ltsp-xinetd-2.3.12-0-i386.tgz
ltsp-ypbind-1.14-0-i386.tgz
ltsp-tcp_wrappers-7.6-0-i386.tgz
ltsp-portmap-4-0-i386.tgz
ltsp-rdesktop-1.2.0-0-i386.tgz"

LTSP_DEBUG="ltsp-gdb-5.3-0-i386.tgz
ltsp-strace-4.4.94-0-i386.tgz"

LTSP_X="ltsp-x-core-4.3.99.901-0-i386.tgz
ltsp-x-fonts-4.3.99.901-0-i386.tgz
ltsp-x-fonts-100dpi-4.3.99.901-0-i386.tgz
ltsp_x336_3DLabs-3.3.6-0-i386.tgz
ltsp_x336_8514-3.3.6-0-i386.tgz
ltsp_x336_AGX-3.3.6-0-i386.tgz
ltsp_x336_I128-3.3.6-0-i386.tgz
ltsp_x336_Mach32-3.3.6-0-i386.tgz
ltsp_x336_Mach64-3.3.6-0-i386.tgz
ltsp_x336_Mach8-3.3.6-0-i386.tgz
ltsp_x336_Mono-3.3.6-0-i386.tgz
ltsp_x336_P9000-3.3.6-0-i386.tgz
ltsp_x336_S3_S3V-3.3.6-0-i386.tgz
ltsp_x336_SVGA-3.3.6-0-i386.tgz
ltsp_x336_VGA16-3.3.6-0-i386.tgz
ltsp_x336_W32-3.3.6-0-i386.tgz"

LTSP_STUFF="ltspcfg-0.3.tgz
ltsp_kernel-3.0.12-i386.tgz"

for FILE in ${LTSP_CORE} ${LTSP_STUFF}
do
	SRC_URI="${SRC_URI} mirror://sourceforge/ltsp/${FILE}"
done

for FILE in ${LTSP_DEBUG} ${LTSP_STUFF}
do
	SRC_URI="${SRC_URI} debug? ( mirror://sourceforge/ltsp/${FILE} )"
done

for FILE in ${LTSP_X}
do
	SRC_URI="${SRC_URI} X? ( mirror://sourceforge/ltsp/${FILE} )"
done

RDEPEND="X? ( x11-base/xfree )
	virtual/tftp
	sys-apps/xinetd
	net-misc/dhcp
	net-fs/nfs-utils
	net-nds/portmap"

DEPEND="${RDEPEND}"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

S=${WORKDIR}/ltsp

src_unpack() {
	# nothing to unpack
	mkdir ltsp
	cd ltsp

	for FILE in ${LTSP_STUFF}
	do
		tar -xzf ${DISTDIR}/${FILE}
	done
}

src_install() {
	# now unpack the files
	# first the core stuff
	dodir /opt/ltsp
	echo "Installing core packages..."
	for FILE in ${LTSP_CORE}
	do
		tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp 2> /dev/null
	done

	# debug stuff
	if [ `use debug` ]; then
		echo "Installing debug packages..."
		for FILE in ${LTSP_DEBUG}
		do
			tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp 2> /dev/null
		done
	fi

	# X stuff
	if [ `use X` ]; then
		echo "Installing X packages..."
		for FILE in ${LTSP_X}
		do
			tar -xzf ${DISTDIR}/${FILE} -C ${D}/opt/ltsp 2> /dev/null
		done
	fi

	# kernel stuff
	echo "Installing kernel packages..."
	cd ltsp_kernel
	find i386 -print | cpio -pmud --quiet ${D}/opt/ltsp 2> /dev/null
	insinto /tftpboot/lts
	doins vmlinuz-2.4.22-ltsp-2
	cd ..

	# pxe stuff
	insinto /tftpboot/pxe
	doins ${FILESDIR}/eb-5.0.9-rtl8139.lzpxe
	doins ${FILESDIR}/eb-5.0.9-eepro100.lzpxe
	doins ${FILESDIR}/eb-5.0.9-3c905c-tpo.lzpxe

	# config stuff
	echo "Doing several other stuff..."
	dosbin ltspcfg

	# several other stuff
	mv ${D}/opt/ltsp/i386/etc/lts.conf ${D}/opt/ltsp/i386/etc/lts.conf.example
	dodoc COPYING
}

pkg_postinst() {
	einfo
	einfo "Either use ltspcfg to configure your stuff, or follow the guide at gentoo.org:"
	einfo "                   http://www.gentoo.org/doc/en/ltsp.xml                      "
	einfo
}
