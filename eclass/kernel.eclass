# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel.eclass,v 1.3 2002/09/22 01:50:34 lostlogic Exp $
ECLASS=kernel
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst
# This eclass contains the common functions to be used by all lostlogic
# based kernel ebuilds

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="`echo ${P} | \
	sed -e 's:^\(.*\)-sources-[0-9]\+\.[0-9]\+\.[0-9]\+.r*\([0-9]*\)\(.*$\):-\1-r\2\3:'`"
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"
SLOT="0"

if [ $ETYPE = "sources" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( sys-apps/sed >=sys-devel/binutils-2.11.90.0.31 )"
	RDEPEND="${DEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
			   sys-devel/perl
			   >=sys-apps/modutils-2.4.2
			   sys-devel/make )"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -Os -fomit-frame-pointer -I${S}/include"

kernel_exclude() {
	for mask in ${KERNEL_EXCLUDE}; do
		for patch in *${mask}*; do
			einfo "Excluding: ${patch}"
			rm ${patch}
		done
	done
}

kernel_src_unpack() {

	kernel_exclude

	./addpatches . ${WORKDIR}/linux-${KV} || die "Addpatches failed, bad KERNEL_ExCLUDE?"

	find . -iname "*~" | xargs rm

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	cd ${S}
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

kernel_src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

kernel_src_install() {
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
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
}

kernel_pkg_preinst() {
	if [ "$ETYPE" = "headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

kernel_pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${KV} ${ROOT}/usr/src/linux
	fi
}
