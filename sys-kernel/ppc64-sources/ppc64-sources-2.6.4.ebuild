# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc64-sources/ppc64-sources-2.6.4.ebuild,v 1.1 2004/03/31 04:32:28 tgall Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV="2.6.4"

########  last BK changeset in this patch: 1.1390

EXTRAVERSION="`echo ${PV}-${PR/r/ames} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${PV}-${PR/r/ames}

S=${WORKDIR}/linux-${OKV}

inherit eutils

IUSE="extlib"

# What's in this kernel?

# INCLUDED: 2.6 ames snapshot

DESCRIPTION="Full sources for the linux kernel 2.6 with ames's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	mirror://kernel/ppc64-ames264.patch.gz
	ftp://ftp.linuxppc64.org/pub/people/tgall/ppc64-Makefilefix.patch"
#		mirror://gentoo/patches-${OKV}.bz2"
KEYWORDS="-ppc ppc64"
DEPEND=" extlib? ( dev-libs/ucl )"
RDEPEND="sys-apps/module-init-tools"
SLOT=${KV}
PROVIDE="virtual/linux-sources
		virtual/alsa"


src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} ${PF}
	cd ${PF}

	epatch ${DISTDIR}/ppc64-Makefilefix.patch
	cp ${DISTDIR}/ppc64-ames264.patch.gz ${WORKDIR}
	gunzip ${WORKDIR}/ppc64-ames264.patch.gz
	epatch ${WORKDIR}/ppc64-ames264.patch

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
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		ln -sf ${PF} ${ROOT}/usr/src/linux
	fi

	ewarn "Please note that ptyfs support has been removed from devfs"
	ewarn "in the later 2.6 kernels, and you have to compile it in now,"
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
	einfo "for more info about the 2.6 series."
	echo
}
