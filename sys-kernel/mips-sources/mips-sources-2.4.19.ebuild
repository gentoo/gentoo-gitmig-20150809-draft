# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/mips-sources/mips-sources-2.4.19.ebuild,v 1.4 2003/03/24 23:21:30 drobbins Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.4.19
KV=${PVR}
S=${WORKDIR}/linux-${KV}
ETYPE="sources"
IUSE="build"

# What's in this kernel?

# INCLUDED:
# 1) kernel-source-2.4.19_2.4.19-5
# 2) kernel-patch-2.4.19-mips_2.4.19-0.020911.5
#	- Debian patch to provide necessary updates to the mips kernel.

DESCRIPTION="Full sources for the Gentoo Linux MIPS kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://hubcap.clemson.edu/~nwourms/linux-${KV}-mips-patch.diff.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="mips -ppc -x86 -sparc -alpha"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	DEPEND=">=sys-devel/binutils-2.13.90.0.16"
	RDEPEND=">=sys-libs/ncurses-5.2
		dev-lang/perl
		sys-apps/modutils
		sys-devel/make"
fi

GENTOOPATCH=${DISTDIR}/linux-${KV}-mips-patch.diff.bz2

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	cd ${S}
	pwd
	bzcat ${GENTOOPATCH} | patch -p1 || die # Patch the kernel

	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
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
		cd ${S}
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
		make dep
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-mips/* ${D}/usr/include/asm
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
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
