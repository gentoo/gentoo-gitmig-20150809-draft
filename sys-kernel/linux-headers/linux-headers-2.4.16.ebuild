# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.16.ebuild,v 1.19 2004/01/08 07:04:10 iggy Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${OKV}
S=${WORKDIR}/linux-${KV}
S2=${WORKDIR}/linux-${KV}-extras
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc"

# Patch versions. We now have a new system.  To enable a patch, set the patch version.  To disable
# a patch, comment out the patch version and it won't be enabled.  In this ebuild, ACPI, low latency
# and preempt patches are enabled, but MOSIX is not.

ACPIV=20011120
LOWLV=2.4.16
PREEV="${KV}-1"
#MOSV=1.5.2

DESCRIPTION="Linux kernel version ${KV} - full sources"

PATCHES=""
SRC_URI="http://www.de.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
[ "$MOSV"  ] && { SRC_URI="$SRC_URI http://www.mosix.cs.huji.ac.il/ftps/MOSIX-${MOSV}.tar.gz"; PATCHES="$PATCHES ${S2}/MOSIX-${MOSV}/patches.${OKV}"; }
[ "$ACPIV" ] && { SRC_URI="$SRC_URI http://developer.intel.com/technology/iapc/acpi/downloads/acpi-${ACPIV}.diff.gz"; PATCHES="$PATCHES ${DISTDIR}/acpi-${ACPIV}.diff.gz"; }
[ "$LOWLV" ] && { SRC_URI="$SRC_URI http://www.zip.com.au/~akpm/linux/${LOWLV}-low-latency.patch.gz"; PATCHES="$PATCHES ${DISTDIR}/${LOWLV}-low-latency.patch.gz"; }
[ "$PREEV" ] && { SRC_URI="$SRC_URI mirror://kernel/linux/kernel/people/rml/preempt-kernel/v2.4/preempt-kernel-rml-${PREEV}.patch" PATCHES="$PATCHES ${DISTDIR}/preempt-kernel-rml-${PREEV}.patch"; }

PROVIDE="virtual/kernel virtual/os-headers"
HOMEPAGE="http://www.kernel.org/ http://www.namesys.com http://www.sistina.com/lvm/ http://developer.intel.com/technology/iapc/acpi/"

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco.
	DEPEND="sys-apps/console-tools virtual/modutils dev-lang/perl"
	RDEPEND=">=sys-libs/ncurses-5.2"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

patchorama() {
	local x
	for x in ${*}
	do
		[ -d "$x" ] && continue
		echo ">>> Applying ${x}..."
		if [ "${x##*.}" = "bz2" ]
		then
			cat $x | bzip2 -d | patch -p1 -l
		elif [ "${x##*.}" = "gz" ]
		then
			cat $x | gzip -d | patch -p1 -l
		else
			patch -p1 -l < $x
		fi
	done
}

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
	patchorama $PATCHES
	echo "Preparing for compilation..."

	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#linux-sources needs to be fully configured, too.  This is the configuration for the default kernel
	cp ${S}/arch/i386/defconfig .config || die
	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly; seems they cant make up their mind if it should be a space or tab
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's/#export\tINSTALL_PATH/export\tINSTALL_PATH/'		\
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
		cp -ax ${WORKDIR}/* ${D}/usr/src
	elif [ "$PN" = "linux-headers" ]
	then
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
	if [ -d ${D}/usr/src/linux-${KV} ]
	then
		#don't overwrite existing .config if present
		cd ${D}/usr/src/linux-${KV}
		if [ -e .config ]
		then
			cp -a .config .config.eg
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
