# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/sparc-sources/sparc-sources-2.4.20_pre10.ebuild,v 1.1 2002/10/09 09:46:14 seemant Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

IUSE="build"

#we use this next variable to avoid duplicating stuff on cvs
OKV=2.4.19
MY_PVR=${PVR/_/-}
[ "${PR}" == "r0" ] && KV=${MY_PVR}-sparc || KV=${PV}-sparc-${PR}
EXTRAVERSION="`echo ${KV}|sed -e 's:[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\):\1:'`"
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

#Documentation on the patches contained in this kernel will be installed
#to /usr/share/doc/sparc-sources-${PVR}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Linux kernel for Sparc64"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://www.kernel.org/pub/linux/kernel/v2.4/testing/patch-${MY_PVR}.gz
	mirror://gentoo/patches-${MY_PVR}-sparc.tar.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc sparc sparc64 -alpha"

if [ $ETYPE = "sources" ]
then
	DEPEND="!build? ( >=sys-devel/binutils-2.11.90.0.31 )"
	RDEPEND="${RDEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
			   sys-devel/perl
			   >=sys-apps/modutils-2.4.2
			   sys-devel/make )"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"

src_unpack() {
	unpack ${A}
	mv linux-${OKV} linux-${KV} || die

	# patch the kernel to the latest sources
	cd ${S}
	patch -p1 < ${WORKDIR}/patch-${MY_PVR} || die

	# Now we need to deal with the tarball of patches.
	cd ${WORKDIR}/${KV} || die "No patch dir to change to"
	./addpatches . ${WORKDIR}/linux-${KV} || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	cd ${S}
	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
	    -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
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
		cat ${WORKDIR}/${KV}/docs/* > patches.txt
		dodoc patches.txt
		mv ${WORKDIR}/linux* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		use x86 && cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
		use sparc && cp -ax ${S}/include/asm-sparc/* ${D}/usr/include/asm
		use sparc64 && cp -ax ${S}/include/asm-sparc64/* ${D}/usr/include/asm
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
