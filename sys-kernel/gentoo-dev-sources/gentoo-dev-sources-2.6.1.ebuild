# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.1.ebuild,v 1.1 2004/01/09 16:25:31 brad_mssw Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

# Kernel Version before Gentoo Patches
TKV=${PV/-r*/}
OKV=${TKV/_rc/-rc}
OKV=${OKV/_pre/-bk}

KVONLY=${OKV/-*/}
KEXT=${TKV/${KVONLY}/}
KMAJ=`echo ${KVONLY} | cut -d. -f1`
KMIN=`echo ${KVONLY} | cut -d. -f2`
KREL=`echo ${KVONLY} | cut -d. -f3`

# Kernel Version before official Patches
if [ "${KEXT}" = "" ]
then
	OFFICIAL_KV=${KVONLY}
else
	OFFICIAL_KV="${KMAJ}.${KMIN}.`expr ${KREL} - 1`"
fi

#version of gentoo patchset
# set to 0 for no patchset
GPV=1.15

[ ${PR} == "r0" ] && EXTRAVERSION="-gentoo" || EXTRAVERSION="-gentoo-${PR}"
KV=${OKV}${EXTRAVERSION}

S=${WORKDIR}/linux-${KV}

DESCRIPTION="Full sources for the development branch of the Linux kernel (2.6)"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"

if [ "${GPV}" != "0" ]
then
	GPV_SRC="http://dev.gentoo.org/~brad_mssw/kernel_patches/DO_NOT_UPLOAD_TO_MIRRORS_WITHOUT_ASKING_ME_FIRST/genpatches-2.6-${GPV}.tar.bz2"
#	GPV_SRC="mirror://gentoo/genpatches-2.6-${GPV}.tar.bz2"
fi
if [ "${KEXT}" != "" ]
then
	KP_SRC="mirror://kernel/linux/kernel/v2.6/testing/patch-${OKV}.bz2"
fi

SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OFFICIAL_KV}.tar.bz2
	${KP_SRC}
	${GPV_SRC}"
LICENSE="GPL-2"
SLOT="${KV}"
#KEYWORDS="-*"
KEYWORDS="-* x86 amd64 ~mips ~hppa ~sparc ~alpha"
PROVIDE="virtual/linux-sources virtual/alsa"
#RESTRICT="nomirror"

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

	if [ "${GPV}" != "0" ]
	then
		unpack genpatches-2.6-${GPV}.tar.bz2
	fi
	unpack linux-${OFFICIAL_KV}.tar.bz2
	mv linux-${OFFICIAL_KV} linux-${KV} || die "Unable to move source tree to ${KV}."
	cd ${S}

	if [ "${KEXT}" != "" ]
	then
		epatch "${DISTDIR}/patch-${OKV}.bz2"
	fi

	if [ "${GPV}" != "0" ]
	then
		# apply gentoo patches
		# epatch ${DISTDIR}/genpatches-2.6-${GPV}.tar.bz2
		PATCHES=`find ${WORKDIR}/genpatches-2.6-${GPV} -type f -name *.patch | sort`
		for file in ${PATCHES}
		do
			epatch $file
		done
	fi

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
	ewarn "Otherwise, you will get the dreaded \"Uncompressing the Kernel\""
	ewarn "error."
	echo
}
