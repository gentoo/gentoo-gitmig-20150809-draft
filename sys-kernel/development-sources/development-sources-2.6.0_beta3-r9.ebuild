# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/development-sources/development-sources-2.6.0_beta3-r9.ebuild,v 1.2 2003/09/07 07:26:00 msterret Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

OKV=${PV/_beta/-test}

PKV=${PF/_beta/-test}
PKV=${PKV/-r/-bk}
PKV=${PKV//${PN}-}

KV=${PV/_beta/-test}

S=${WORKDIR}/linux-${PKV}
ETYPE="sources"

IUSE="alsa"
DESCRIPTION="Full sources for the Development Branch of the Linux kernel"
PATCH_URI="http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-${PKV}.bz2"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2 ${PATCH_URI}"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${PKV}"
KEYWORDS="-* ~x86"
PROVIDE="virtual/linux-sources"
[ -n "$(use alsa)" ] && PROVIDE="${PROVIDE} virtual/alsa"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl
		 sys-devel/make
		 sys-apps/module-init-tools"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} linux-${PKV}
	cd ${S}
	epatch ${DISTDIR}/patch-${PKV}.bz2

	unset ARCH
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *
}

src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
}

pkg_preinst() {
	if [ "$ETYPE" = "headers" ]
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux-beta ]
	then

		ln -sf linux-${PKV} ${ROOT}/usr/src/linux-beta
	fi

	echo
	ewarn "Please note that ptyfs support has been removed from devfs"
	ewarn "in the later 2.5.x kernels, and you have to compile it in now,"
	ewarn "or else you will get errors when trying to open a pty."
	ewarn "The option is File systems->Pseudo filesystems->/dev/pts"
	ewarn "filesystem."
	echo
	ewarn "Also, note that you must compile in support for"
	ewarn "input devices (Input device support->Input devices),"
	ewarn "the virtual terminal (Character Devices->Virtual terminal),"
	ewarn "vga_console (Graphics Support->Console...->VGA text console)"
	ewarn "and the vt_console (Character Devices->Support for console...)."
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""
	ewarn "error."
	echo
}
