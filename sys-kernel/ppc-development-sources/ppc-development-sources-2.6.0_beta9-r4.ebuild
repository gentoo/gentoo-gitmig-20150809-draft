# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-development-sources/ppc-development-sources-2.6.0_beta9-r4.ebuild,v 1.4 2003/12/29 01:29:28 lu_zero Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV=${PV/_beta/-test}

EXTRAVERSION="`echo ${OKV}-${PR/r/benh} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${OKV}-${PR/r/benh}

S=${WORKDIR}/linux-${KV}

inherit eutils

# What's in this kernel?

# INCLUDED: 2.6 vanilla + benh bk snapshot

DESCRIPTION="Full sources for the development linux kernel 2.6 with benh's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${PV/_beta/-test}.tar.bz2
		mirror://gentoo/patches-${KV}.bz2"
KEYWORDS="~ppc"
RDEPEND="sys-apps/module-init-tools"
SLOT=${KV}
PROVIDE="virtual/linux-sources
		virtual/alsa"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} ${PF}
	cd ${PF}
	bzcat ${DISTDIR}/patches-${KV}.bz2 | patch -p1 || die "patch failed"
	find . -iname "*~" | xargs rm 2> /dev/null

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
			Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	cd  Documentation/DocBook
	sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
		&& mv Makefile.new Makefile

	cd ${WORKDIR}/${PF}
	#This is needed on > 2.5
	MY_ARCH=${ARCH}
	unset ARCH
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die "make mrproper died"
	ARCH=${MY_ARCH}

}

src_install() {
	dodir /usr/src
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
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
	ewarn "and the vt_console (Character Devices->Support for console...)."
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""
	ewarn "error."
	echo
	ewarn "DONT enable preempt as it's very broken on ppc currently, also"
	ewarn "rivafb and the mac floppy drivers are both broken. NVidia"
	ewarn "users should use the openfirmware framebuffer for now."
	echo
	einfo "Consult http://www.linux.org.uk/~davej/docs/post-halloween-2.6.txt"
	einfo "for more info about the development series."
	echo
}
