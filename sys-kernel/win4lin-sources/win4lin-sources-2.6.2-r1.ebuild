# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/win4lin-sources/win4lin-sources-2.6.2-r1.ebuild,v 1.1 2004/02/18 21:12:04 plasmaroo Exp $
# OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV=${PV}
KV=${PV}-win4lin
S=${WORKDIR}/linux-${OKV}

ETYPE="sources"
DESCRIPTION="Full sources for the Development Branch of the Linux kernel"

SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	 http://www.netraverse.com/member/downloads/files/mki-adapter26_1_3_3.patch
	 http://www.netraverse.com/member/downloads/files/Kernel-Win4Lin3-${OKV}.patch"

HOMEPAGE="http://www.kernel.org/ http://www.netraverse.com/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~x86"
PROVIDE="virtual/linux-sources virtual/alsa"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl
		 sys-devel/make
		 sys-apps/module-init-tools"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	cd ${S}

	epatch ${DISTDIR}/Kernel-Win4Lin3-${OKV}.patch || die "Error: Failed to appky Win4Lin3 patch!"
	ebegin "Applying mki-adapter26_1_3_3.patch"
	patch -Np1 -i ${DISTDIR}/mki-adapter26_1_3_3.patch > /dev/null 2>&1 || die "Error: Failed to apply mki-adapter patch!"
	eend $?

	epatch ${FILESDIR}/${PN}-2.6.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${PN}-2.6.munmap.patch || die "Failed to apply munmap patch!"

	unset ARCH
	# Sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	# Fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *
}

src_install() {

	dodir /usr/src
	echo ">>> Copying sources..."
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	mv ${WORKDIR}/* ${D}/usr/src

}

pkg_postinst() {

	[ ! -e "${ROOT}usr/src/linux-beta" ] && ln -sf linux-${OKV} ${ROOT}/usr/src/linux-beta
	[ ! -e "${ROOT}usr/src/linux" ] && ln -sf linux-${OKV} ${ROOT}/usr/src/linux
	mkdir -p ${ROOT}sys

	echo
	ewarn "Please note that ptyfs support has been removed from devfs"
	ewarn "and you have to compile it in now, or else you will get"
	ewarn "errors when trying to open a pty. The option is:"
	ewarn "File systems -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	ewarn "Also, note that you must compile in support for"
	ewarn "input devices (Input device support->Input devices),"
	ewarn "the virtual terminal (Character Devices->Virtual terminal),"
	ewarn "vga_console (Graphics Support->Console...->VGA text console)"
	ewarn "and the vt_console (Character Devices->Support for console...)."
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""
	ewarn "error."
	echo
	ewarn "PLEASE NOTE THIS IS NOT OFFICIALLY SUPPORTED BY GENTOO!"
	sleep 5
	echo

}
