# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/redhat-sources/redhat-sources-2.4.18.0.13.ebuild,v 1.2 2002/04/28 05:35:05 blocke Exp $

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
ETYPE="sources"

# INCLUDED:
# Redhat Skipjack Beta 2 Kernel

KERNVER="2.4.18-0.13"
S=${WORKDIR}/linux-redhat-${KERNVER}

DESCRIPTION="Full sources for the Redhat Linux kernel"
SRC_URI="http://ftp.dulug.duke.edu/pub2/redhat/linux/beta/skipjack/en/os/i386/RedHat/RPMS/kernel-source-${KERNVER}.i386.rpm"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.redhat.com/" 

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31 >=app-arch/rpm-4.0.4 sys-apps/cpio"
	RDEPEND=">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	rpm2cpio ${DISTDIR}/kernel-source-${KERNVER}.i386.rpm | cpio -i --make-directories || die

	mv usr/src/linux-${KERNVER} linux-redhat-${KERNVER} || die
	rmdir usr/src usr
	cd ${S}
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make distclean || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' -e 's|custom ||' \
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
	cd ${ROOT}usr/src/linux-redhat-${KERNVER}
	make mrproper
	if [ -e "${ROOT}usr/src/linux/.config" ]
	then
		cp "${ROOT}usr/src/linux/.config" .config
		#we only make dep when upgrading to a new kernel (with existing config)
		#The default setting will be selected.
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
		make dep
	else
		cp "${ROOT}usr/src/linux-redhat-${KERNVER}/arch/i386/defconfig" .config
	fi
	#remove /usr/src/linux symlink
	rm -f ${ROOT}/usr/src/linux
	#set up a new one
	ln -sf linux-redhat-${KERNVER} ${ROOT}/usr/src/linux
}
