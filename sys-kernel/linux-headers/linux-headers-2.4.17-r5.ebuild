# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.17-r5.ebuild,v 1.19 2004/01/08 07:04:10 iggy Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${PVR}
S=${WORKDIR}/linux-${KV}
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

# What's in this kernel?

# INCLUDED:
#   xfs (13 Feb 2002 CVS)
#   read-latency2.patch from http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre9/
#     (improves multiple disk read/write IO performance)
#   fastpte
#     (enables an option to do fast scanning of the page tables)
#   preempt-kernel-rml-2.4.17-3 from http://www.tech9.net/rml/linux/
#     (preemptible kernel)
#   loopback device deadlock fixes from akpm

# ADDED in 2.4.17-r5:
#   acpi-20020214-2.4.17.diff.gz from http://sourceforge.net/projects/acpi
#   This patch should close bug #689 which was sent upstream.

# REMOVED from 2.4.17-r5:
#   ide.2.4.17.02072002.patch from http://www.linuxdiskcert.org/
#   (revamped IDE code; this closes bug #690; we'll add it back as soon as the
#    confirmed with author completion error is fixed (probably in the next release))


DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2  mirror://gentoo/linux-gentoo-${KV}.patch.bz2"
PROVIDE="virtual/kernel virtual/os-headers"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"

XFSV=20020124

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl >=sys-apps/xfsprogs-${XFSV} sys-apps/kbd >=sys-apps/dmapi-${XFSV} virtual/modutils sys-devel/make >=sys-apps/attr-${XFSV} >=sys-apps/acl-${XFSV} >=sys-apps/xfsdump-${XFSV}"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	cd ${S}
	cat ${DISTDIR}/linux-gentoo-${KV}.patch.bz2 | bzip2 -d | patch -p1 || die

	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die

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
	if [ "$PN" = "linux-headers" ]
	then
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$PN" = "linux-sources" ]
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
	if [ "$PN" = "linux-headers" ]
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

pkg_postinst() {
	[ "$PN" = "linux-headers" ] && return
	cd ${ROOT}usr/src/linux-${KV}
	if [ -e "${ROOT}usr/src/linux/.config" ]
	then
		cp "${ROOT}usr/src/linux/.config" .config
	else
		cp "${ROOT}usr/src/linux-${KV}/arch/i386/defconfig" .config
	fi
	#The default setting will be selected.
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."
	#remove /usr/src/linux symlink
	rm -f ${ROOT}/usr/src/linux
	#set up a new one
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
	#this will generate include/linux/modversions.h, among other things:
	cd ${ROOT}/usr/src/linux-${KV}
	make dep
}
