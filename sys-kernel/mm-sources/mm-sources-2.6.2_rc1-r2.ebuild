# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.2_rc1-r2.ebuild,v 1.2 2004/01/23 18:45:04 lostlogic Exp $
# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV=2.6.1

EXTRAVERSION="`echo ${PV/_/-}-${PR/r/mm} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${PV/_/-}-${PR/r/mm}
S=${WORKDIR}/linux-${KV}

inherit eutils

# What's in this kernel?

# INCLUDED:
# The development branch of the linux kernel with Andrew Morton's patch

DESCRIPTION="Full sources for the development linux kernel with Andrew Morton's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	 mirror://kernel/linux/kernel/v2.6/testing/patch-${KV/-mm*/}.bz2
	 mirror://kernel/linux/kernel/people/akpm/patches/2.6/${OKV}/${KV}/${KV}.bz2"
KEYWORDS="~x86"
RDEPEND="sys-apps/module-init-tools"
SLOT=${KV}
PROVIDE="virtual/linux-sources
		virtual/alsa"

src_unpack() {

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} linux-${KV}
	cd ${S}
	bzcat ${DISTDIR}/patch-${KV/-mm*/}.bz2 | patch -p1 || die "rc1 patch failed"
	bzcat ${DISTDIR}/${KV}.bz2 | patch -p1 || die "mm patch failed"
	find . -iname "*~" | xargs rm 2> /dev/null

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION

	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
			Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	cd  ${S}/Documentation/DocBook
	sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
		&& mv Makefile.new Makefile
	cd ${S}

	# This is needed on > 2.5
	MY_ARCH=${ARCH}
	unset ARCH

	# Sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die "make mrproper died"
	ARCH=${MY_ARCH}

}

pkg_postinst() {
	if [ ! -e ${ROOT}usr/src/linux-beta ]
	then
		ln -sf linux-${KV} ${ROOT}/usr/src/linux-beta
	fi

	ewarn "Please note that ptyfs support has been removed from devfs"
	ewarn "and you have to compile it in now, or else you will get"
	ewarn "errors when trying to open a pty. The options are:"
	ewarn "Device Drivers -> Character devices -> Unix98 PTY support and"
	ewarn "File systems -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	ewarn "Also, note that you must compile in support for"
	ewarn "input devices (Input device support->Input devices),"
	ewarn "the virtual terminal (Character Devices->Virtual terminal),"
	ewarn "vga_console (Graphics Support->Console...->VGA text console)"
	ewarn "and the vt_console (Character Devices->Support for console...)."
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""        ewarn "error."
	echo
	einfo "Consult http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt"
	einfo "for more info about the development series."
	echo
}
