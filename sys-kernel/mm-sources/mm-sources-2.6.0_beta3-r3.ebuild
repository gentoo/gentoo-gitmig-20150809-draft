# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mm-sources/mm-sources-2.6.0_beta3-r3.ebuild,v 1.2 2003/08/20 12:28:39 latexer Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

OKV=${PV/_beta/-test}

EXTRAVERSION="`echo ${OKV}-${PR/r/mm} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${OKV}-${PR/r/mm}

inherit kernel

# What's in this kernel?

# INCLUDED:
# The development branch of the linux kernel with Andrew Morton's patch

DESCRIPTION="Full sources for the development linux kernel with Andrew Morton's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV/_beta/-test}.tar.bz2
mirror://kernel/linux/kernel/people/akpm/patches/2.6/${PV/_beta/-test}/${KV}/${KV}.bz2"
KEYWORDS="x86 ppc"
RDEPEND="sys-apps/module-init-tools"
SLOT=${KV}

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} linux-${KV}
	cd ${S}
	bzcat ${DISTDIR}/${KV}.bz2 | patch -p1 || die "mm patch failed"

	unset ARCH
	kernel_universal_unpack

}
pkg_postinst() {
	if [ ! -e ${ROOT}usr/src/linux-beta ]
	then
		ln -sf linux-${KV} ${ROOT}/usr/src/linux-beta
	fi

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
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""        ewarn "error."
	echo
	einfo "Consult http://www.codemonkey.org.uk/post-halloween-2.5.txt"
	einfo "for more info about the development series."
	echo
}
