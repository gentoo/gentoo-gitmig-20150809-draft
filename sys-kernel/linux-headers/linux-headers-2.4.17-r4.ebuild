# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.17-r4.ebuild,v 1.17 2004/01/08 07:04:10 iggy Exp $
#OKV=original kernel version, KV=patched kernel version. They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${PVR}
S=${WORKDIR}/linux-${KV}
S2=${WORKDIR}/linux-${KV}-extras
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

# What's in this kernel?

# INCLUDED:
#	xfs (13 Feb 2002 CVS)
#	read-latency2.patch from http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre9/
#	(improves multiple disk read/write IO performance)
#	fastpte
#	(enables an option to do fast scanning of the page tables)
#	ide.2.4.17.02072002.patch from http://www.linuxdiskcert.org/
#	(revamped IDE code)
#	preempt-kernel-rml-2.4.17-3 from http://www.tech9.net/rml/linux/
#	(preemptible kernel)
#	loopback device deadlock fixes from akpm

# UPDATED in 2.4.17-r4:
#	xfs was updated from 26 Jan 2002 to 13 Feb 2002 CVS
#	ide updated from 01192002 to 02072002
#	preempt was updated from -1 to -3

# REMOVED from 2.4.17-r4:
#	irqrate-a1 (which should close bug #396, possibly others)
#	acpi-20020208-2.4.17.diff.gz from http://sourceforge.net/projects/acpi
#	(see bug #689; this patch conflicts with the stock aic7xxx scsi driver.
#	this bug has been sent upstream)

# Note: enable "Taskfile" options in kernel config if you're using IDE
# The linuxdiskcert site says "no" but the patch author says "yes"

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 mirror://gentoo/linux-gentoo-${KV}.patch.bz2"
PROVIDE="virtual/kernel virtual/os-headers"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"

XFSV=20020124

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco.
	#binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31 sys-apps/console-tools virtual/modutils dev-lang/perl"
	RDEPEND=">=sys-libs/ncurses-5.2 >=sys-apps/xfsprogs-${XFSV} >=sys-apps/dmapi-${XFSV} >=sys-apps/attr-${XFSV} >=sys-apps/acl-${XFSV} >=sys-apps/xfsdump-${XFSV}"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	mkdir ${S2}

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	dodir /usr/src/linux-${KV}-extras
	if [ "$MOSIX" ]
	then
		cd ${S2}
		tar -xz --no-same-owner -f ${DISTDIR}/MOSIX-${MOSV}.tar.gz MOSIX-${MOSV}/patches.${OKV}
	fi
	cd ${S}
	cat ${DISTDIR}/linux-gentoo-${KV}.patch.bz2 | bzip2 -d | patch -p1 || die
	echo "Preparing for compilation..."

	#sometimes we have icky kernel symbols; this seems to get rid of them
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
