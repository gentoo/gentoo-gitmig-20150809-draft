# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.0.ebuild,v 1.4 2004/01/05 21:43:49 brad_mssw Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

#Original Kernel Version before Patches
# eg: 2.6.0-test8
OKV=${PV/_beta/-test}
OKV=${OKV/-r*//}

#version of gentoo patchset
GPV=0.9

[ ${PR} == "r0" ] && EXTRAVERSION="-gentoo" || EXTRAVERSION="-gentoo-${PR}"
KV=${OKV}${EXTRAVERSION}

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the development branch of the Linux kernel (2.6)"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
GPV_SRC="http://dev.gentoo.org/~brad_mssw/kernel_patches/2.6.0/genpatches-2.6-${GPV}.tar.bz2"
#GPV_SRC="mirror://gentoo/genpatches-2.6-${GPV}.tar.bz2"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	 ${GPV_SRC}"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="-* x86 amd64 ~mips ~hppa ~sparc ~alpha"
PROVIDE="virtual/linux-sources virtual/alsa"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl
		 sys-devel/make
		 sys-apps/module-init-tools"
fi

src_unpack() {
	cd ${WORKDIR}
	unpack genpatches-2.6-${GPV}.tar.bz2
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die "Unable to move source tree to ${KV}."
	cd ${S}

	# apply gentoo patches
	# epatch ${DISTDIR}/genpatches-2.6-${GPV}.tar.bz2
	PATCHES=`find ${WORKDIR}/genpatches-${GPV} -type f -name *.patch | sort`
	for file in ${PATCHES}
	do
		epatch $file
	done

	# Our EXTRAVERSION needs to be appended to the end for the Makefile
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
	-e "s:EXTRAVERSION \(=.*\):EXTRAVERSION \1${EXTRAVERSION}:" Makefile > Makefile.new

#	rm -f Makefile
#	mv Makefile.new Makefile

	kernel_universal_unpack

	# Working around a bug in kernel.eclass, move the .new file after universal_unpack
	rm -f Makefile
	mv Makefile.new Makefile
}

pkg_install() {
	kernel_src_install
}

pkg_postinst() {
	kernel_pkg_postinst

	if [ ! -h "/usr/src/linux-beta" ]
	then
		ln -sf /usr/src/linux-${KV} ${ROOT}/usr/src/linux-beta
	fi

	if [ ! -h "/usr/src/linux" ]
	then
		ln -sf /usr/src/linux-${KV} ${ROOT}/usr/src/linux
	fi

	# Don't forget to make directory for sysfs
	if [ ! -d "/sys" ]
	then
		mkdir /sys
	fi

	echo
	eerror "IMPORTANT:"
	eerror "ptyfs support has now been dropped from devfs and as a"
	eerror "result you are now required to compile this support into"
	eerror "the kernel. You can do so by enabling the following option"
	eerror "	File systems -> Pseudo filesystems -> /dev/pts filesystem."
	echo
	eerror "To prevent the problem while uncompressing the kernel image"
	eerror "you should also enable:"
	eerror "	Input Devices (Input Device Support -> Input Devices),"
	eerror "	Virtual Terminal (Character Devices -> Virtual Terminal),"
	eerror "	vga_console (Graphics Support -> Console... -> VGA Text Console)"
	eerror "	vt_console (Character Devices -> Support for Console...)."
	echo
}
