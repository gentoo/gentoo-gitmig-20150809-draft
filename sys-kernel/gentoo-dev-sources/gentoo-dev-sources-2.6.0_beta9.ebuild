# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-dev-sources/gentoo-dev-sources-2.6.0_beta9.ebuild,v 1.1 2003/10/30 17:10:51 johnm Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#Original Kernel Version before Patches
# eg: 2.6.0-test8
OKV=${PV/_beta/-test}
OKV=${OKV/-r*//}

#version of gentoo patchset
GPV=0.3

[ ${PR} == "r0" ] && EXTRAVERSION="-gentoo" || EXTRAVERSION="-gentoo-${PR}"
KV=${OKV}${EXTRAVERSION}

ETYPE="sources"
IUSE="build"

inherit kernel

DESCRIPTION="Full sources for the development branch of the Linux kernel (2.6)"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
SRC_URI="mirror://kernel/linux/kernel/v2.6/linux-${OKV}.tar.bz2
	 mirror://gentoo/distfiles/genpatches-2.6-${GPV}.tar.bz2"
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
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die "Unable to move source tree to ${KV}."
	cd ${S}

	# apply gentoo patches
	epatch ${DISTDIR}/genpatches-2.6-${GPV}.tar.bz2

	#-----
	## Current kernel_universal_unpack is broken with 2.6
	## using this until the issue has been rectified.
	#kernel_universal_unpack

	# remove all tilde suffixed files
	find . -iname "*~" -exec rm {} \;

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
	    -e "s:^\(EXTRAVERSION =\).*:\1 -$(echo ${KV} | cut -d- -f2,3,4,5):" \
		Makefile.orig > Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	cd  ${S}/Documentation/DocBook
	sed -e "s:db2:docbook2:g" Makefile > Makefile.new \
			&& mv Makefile.new Makefile
	cd ${S}

	if [ ${ETYPE} == "headers" ]
	then
		MY_ARCH=${ARCH}
		unset ${ARCH}
		make mrproper || die "make mrproper died"
		ARCH=${MY_ARCH}
	fi
}

pkg_install() {
	## Using this until kernel_src_unpack works with 2.6
	#
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *

	cd ${S}
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		if [ -d "${WORKDIR}/${KV}/docs/" ]
		then
			for file in $(ls -1 ${WORKDIR}/${KV}/docs/)
			do
				echo "XX_${file}*" >> patches.txt
				cat ${WORKDIR}/${KV}/docs/${file} >> patches.txt
			done
		fi
		if [ -f patches.txt ]; then
			dodoc patches.txt
		fi
		mv ${WORKDIR}/linux* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		cp -ax ${S}/include/asm/* ${D}/usr/include/asm
	fi
}

pkg_postinst() {
	kernel_pkg_postinst

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
