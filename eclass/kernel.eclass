# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/kernel.eclass,v 1.26 2003/05/30 01:52:40 kain Exp $
#
# This eclass contains the common functions to be used by all lostlogic
# based kernel ebuilds
# with error handling contributions by gerk, and small fixes by zwelch
# small naming fix by kain

ECLASS=kernel
EXPORT_FUNCTIONS src_unpack src_compile src_install pkg_preinst pkg_postinst

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="`echo ${PN}-${PV}-${PR} | \
	sed -e 's:^\(.*\)-\(.*\)-[0-9]\+\.[0-9]\+\.[0-9]\+.r*\([0-9]\+\)\(_[^-_]\+\)\?\(-r[0-9]\+\)\?$:-\1-r\3\4:'`"
KV=${OKV}${EXTRAVERSION}
S=${WORKDIR}/linux-${KV}
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/" 
LICENSE="GPL-2"

if [ "${ETYPE}" = "sources" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND="!build? ( sys-apps/sed
			  >=sys-devel/binutils-2.11.90.0.31 )
		app-admin/addpatches"
	RDEPEND="${DEPEND}
		 !build? ( >=sys-libs/ncurses-5.2
			   tcltk? dev-lang/tk
			   dev-lang/perl
			   virtual/modutils
			   sys-devel/make )"
	PROVIDE="virtual/linux-sources"

elif [ "${ETYPE}" = "headers" ]
then
	PROVIDE="virtual/kernel virtual/os-headers"
else
	eerror "Unknown ETYPE=\"${ETYPE}\"!"
	die
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

kernel_universal_unpack() {

	echo "KV=${KV}" > /tmp/KV
	find . -iname "*~" | xargs rm 2> /dev/null

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

	# this file is required for other things to build properly, 
	#  so we autogenerate it
	make include/linux/version.h || die

}

kernel_src_unpack() {

	kernel_exclude

	/usr/bin/addpatches . ${WORKDIR}/linux-${KV} || \
		die "Addpatches failed, bad KERNEL_EXCLUDE?"

	kernel_universal_unpack

}

kernel_src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

kernel_src_install() {
	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R root:root *
	chmod -R a+r-w+X,u+w *

	cd ${S}
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		for file in `ls -1 ${WORKDIR}/${KV}/docs/`; do
			echo "XX_${file}*" >> patches.txt
			cat ${WORKDIR}/${KV}/docs/${file} >> patches.txt
		done
		dodoc patches.txt
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

