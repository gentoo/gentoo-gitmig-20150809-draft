# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/xfs-sources/xfs-sources-2.4.19.ebuild,v 1.1 2002/09/03 19:26:45 lostlogic Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${OKV}-xfs
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

# What's in this kernel?

# INCLUDED:
# This kernel is a straight XFS CVS snapshot from 13 Aug 2002 at 01:22 UTC
# And evms support from http://evms.sourceforge.net/

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 ftp://oss.sgi.com/projects/xfs/download/patches/2.4.19/xfs-2.4.19-all-i386.bz2
	 http://gentoo.lostlogicx.com/patch-2.4.19-xfs.bz2"

PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://oss.sgi.com/projects/xfs http://evms.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

if [ $ETYPE = "sources" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( >=sys-devel/binutils-2.11.90.0.31
			  sys-apps/xfsprogs )"
	RDEPEND="${DEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
			   sys-devel/perl
			   >=sys-apps/modutils-2.4.2
			   sys-devel/make )"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd ${S}
	bzcat ${DISTDIR}/xfs-${OKV}-all-i386.bz2 | patch -p1 || die
	bzcat ${DISTDIR}/patch-${KV}.bz2 | patch -p1 || die
	
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
            -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
		Makefile.orig > Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	#sometimes we have icky kernel symbols; this seems to get rid of them
	make distclean || die

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die
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
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
