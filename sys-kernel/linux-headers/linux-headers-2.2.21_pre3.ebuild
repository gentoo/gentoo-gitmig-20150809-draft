# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.2.21_pre3.ebuild,v 1.18 2004/01/08 07:04:10 iggy Exp $
#OKV=original kernel version, KV=patched kernel version. They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.2.20
KV=${PVR}
S=${WORKDIR}/linux-${KV}
# don't need linux-extras right now
#S2=${WORKDIR}/linux-${KV}-extras

# What's in this kernel?

# INCLUDED:
#	Alan Cox's patch-2.2.21-pre3
#	R. Gooch's devfs-patch-v99.21
#	Reiserfs linux-2.2.19-reiserfs-3.5.34-patch

PAC=patch-2.2.21-pre3
PDEVFS=devfs-patch-v99.21
PREISERFS=linux-2.2.19-reiserfs-3.5.34-patch

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.2/linux-${OKV}.tar.bz2
	mirror://kernel/linux/kernel/v2.2/testing/${PAC}.gz
	ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/kernel-patches/v2.2/${PDEVFS}.gz
	ftp://ftp.namesys.com/pub/reiserfs-for-2.2/${PREISERFS}.bz2"
PROVIDE="virtual/kernel virtual/os-headers"
HOMEPAGE="http://www.kernel.org/
	http://www.atnf.csiro.au/~rgooch/linux/kernel-patches.html/
	http://www.namesys.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#The following two notes may not be true w/ 2.2, but 2.2 seems to work just fine
	# with them, so they stay.
	#console-tools is needed to solve the loadkeys fiasco.
	#binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31 sys-apps/console-tools virtual/modutils dev-lang/perl"

	RDEPEND=">=sys-libs/ncurses-5.2 >=sys-apps/baselayout-1.7.4"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	#mkdir ${S2}

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	#dodir /usr/src/linux-${KV}-extras
	zcat ${DISTDIR}/${PAC}.gz | patch -d linux-${KV} -p1 || die
	zcat ${DISTDIR}/${PDEVFS}.gz | patch -d linux-${KV} -p1 || die
	bzcat ${DISTDIR}/${PREISERFS}.bz2 | patch -d linux-${KV} -p1 || die
	echo "Preparing for compilation..."

	#sometimes we have icky kernel symbols; this seems to get rid of them
	cd ${S}
	make mrproper || die

	#linux-sources needs to be fully configured, too. This is the configuration for the default kernel
	cp ${S}/arch/i386/defconfig .config || die
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
}

src_compile() {
	if [ "${PN}" = "linux-headers" ]
	then
		cd ${S}
		make include/linux/autoconf.h include/linux/version.h || die
	fi
}

src_install() {
	if [ "$PN" = "linux-sources" ]
	then
		dodir /usr/src
		cd ${S}
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	elif [ "$PN" = "linux-headers" ]
	then
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
	if [ -d ${D}/usr/src/linux-${KV} ]
	then
		cd ${D}/usr/src/linux-${KV}
		if [ -e .config ]
		then
			mv .config .config.eg
		fi
	fi
}

pkg_preinst() {
	if [ "$PN" = "linux-headers" ]
	then
		if [ -L ${ROOT}usr/include/linux ]
		then
			rm ${ROOT}usr/include/linux
		fi
		if [ -L ${ROOT}usr/include/asm ]
		then
			rm ${ROOT}usr/include/asm
		fi
	fi
}

pkg_postinst() {
	[ "$PN" = "linux-headers" ] && return
	rm -f ${ROOT}/usr/src/linux
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
	#copy over our .config if one isn't already present
	cd ${ROOT}/usr/src/linux-${KV}
	if [ "${PN}" = "linux-sources" ] && [ -e .config.eg ] && [ ! -e .config ]
	then
		cp -a .config.eg .config
	fi
}
