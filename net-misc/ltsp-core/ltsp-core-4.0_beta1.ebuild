# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ltsp-core/ltsp-core-4.0_beta1.ebuild,v 1.3 2003/09/05 22:13:37 msterret Exp $

# TODO: xdm configuration, dhcp-pxe example

IUSE="X debug"

DESCRIPTION="LTSP - Linux Terminal Server Project"
HOMEPAGE="http://www.ltsp.org/"
SRC_URI="mirror://sourceforge/ltsp/ltsp_kernel-3.0.9-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-bash-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-busybox-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-devfsd-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-e2fsprogs-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-getltscfg-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-glibc-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-lp_server-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-ltsptree-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-modutils-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-ncurses-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-open-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-pci_scan-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-popt-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-prep_swap-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-startsess-0.02-0-i386.tgz
	http://www.ltsp.org/ltsp/ltsp-sysvinit-0.02-0-i386.tgz
	mirror://sourceforge/ltsp/ltspcfg-0.2.tgz
	debug? (
		http://www.ltsp.org/ltsp/ltsp-strace-0.02-0-i386.tgz
		http://www.ltsp.org/ltsp/ltsp-gdb-0.02-0-i386.tgz )
	X? (
		http://www.ltsp.org/ltsp/ltsp-x-core-0.02-0-i386.tgz
		http://www.ltsp.org/ltsp/ltsp-x-fonts-0.02-0-i386.tgz
		http://www.ltsp.org/ltsp/ltsp-x-fonts-100dpi-0.02-0-i386.tgz )"

RDEPEND="X? ( x11-base/xfree )
	net-misc/tftp-hpa
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
	tar -xzf ${DISTDIR}/ltspcfg-0.2.tgz
	tar -xzf ${DISTDIR}/ltsp_kernel-3.0.9-i386.tgz
}

src_install() {
	# now unpack the files
	# first the core stuff
	dodir /opt/ltsp
	echo "Installing core packages..."
	tar -xzf ${DISTDIR}/ltsp-bash-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-busybox-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-devfsd-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-e2fsprogs-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-getltscfg-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-glibc-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-lp_server-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-ltsptree-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-modutils-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-ncurses-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-open-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-pci_scan-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-popt-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-prep_swap-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-startsess-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	tar -xzf ${DISTDIR}/ltsp-sysvinit-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null

	# debug stuff
	if [ `use debug` ]; then
		echo "Installing debug packages..."
		tar -xzf ${DISTDIR}/ltsp-gdb-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
		tar -xzf ${DISTDIR}/ltsp-strace-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	fi

	# X stuff
	if [ `use X` ]; then
		echo "Installing X packages..."
		tar -xzf ${DISTDIR}/ltsp-x-core-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
		tar -xzf ${DISTDIR}/ltsp-x-fonts-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
		tar -xzf ${DISTDIR}/ltsp-x-fonts-100dpi-0.02-0-i386.tgz -C ${D}/opt/ltsp 2> /dev/null
	fi

	# kernel stuff
	echo "Installing kernel packages..."
	cd ltsp_kernel
	find i386 -print | cpio -pmud --quiet ${D}/opt/ltsp 2> /dev/null
	insinto /tftpboot/lts
	doins vmlinuz-2.4.21-ltsp-1
	doins vmlinuz-2.4.21-ltsp-lpp-1
	insinto /tftpboot/pxe
	doins ${FILESDIR}/eb-5.0.9-rtl8139.lzpxe
	doins ${FILESDIR}/eb-5.0.9-eepro100.lzpxe
	doins ${FILESDIR}/eb-5.0.9-3c905c-tpo.lzpxe
	cd ..

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
