# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/rsbac-sources/rsbac-sources-2.4.20-r1.ebuild,v 1.1 2004/01/07 00:41:57 plasmaroo Exp $

ETYPE="sources"

OKV=${PV}
KV=${PVR}
SLOT="${KV}"

# Kernel patch name
KPATCH=patch-2.4.20-v1.2.1

# Bugfix patch name
BUGFIX=rsbac-bugfix-v1.2.1

# RSBAC packet name
RSBAC=rsbac-v1.2.1

DESCRIPTION="Rule Set Based Access Control (RSBAC) Kernel Patch"
HOMEPAGE="http://www.rsbac.org"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
http://www.rsbac.org/code/rsbac-v1.2.1.tar.bz2
http://www.rsbac.org/patches/v1.2.1/patch-2.4.20-v1.2.1.gz
http://www.rsbac.org/bugfixes/rsbac-bugfix-v1.2.1-1.diff
http://www.rsbac.org/bugfixes/rsbac-bugfix-v1.2.1-2.diff
http://www.rsbac.org/bugfixes/rsbac-bugfix-v1.2.1-3.diff"

LICENSE="GPL-2"
EXTRAVERSION=-rsbac
KEYWORDS="~x86"
IUSE="ncurses"
DEPEND=">=sys-devel/binutils-2.11.90.0.31 dev-lang/perl"
RDEPEND=">=sys-libs/ncurses-5.2"

S=${WORKDIR}/linux-${OKV}-rsbac

src_unpack() {
		unpack linux-${OKV}.tar.bz2
		mv linux-${OKV} linux-${OKV}-rsbac || die
		cp ${DISTDIR}/${BUGFIX}-1.diff ${S} || die "Cannot find bugfix patch"
		cp ${DISTDIR}/${BUGFIX}-2.diff ${S} || die "Cannot find bugfix patch"
		cp ${DISTDIR}/${BUGFIX}-3.diff ${S} || die "Cannot find bugfix patch"
		echo "-> Kernel unpacked..."

		cd ${S}
		unpack ${RSBAC}.tar.bz2 || die "rsbac unpack failed!"
		unpack ${KPATCH}.gz || die "kernel patch unpack failed!"
		echo "-> RSBAC and kernel patch unpacked"

		patch -p1 < ${KPATCH} || die "kernel patching failed!"
		echo "-> Kernel patched..."

		patch -p1 < ${BUGFIX}-1.diff || die "cannot apply fix patch 1"
		echo "-> Fix patch 1 applied"

		patch -p1 < ${BUGFIX}-2.diff || die "cannot apply fix patch 2"
		echo "-> Fix patch 2 applied"

		patch -p1 < ${BUGFIX}-3.diff || die "cannot apply fix patch 1"
		echo "-> Fix patch 3 applied"

		epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
		epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
		epatch ${FILESDIR}/${PN}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"

		# We need to have our kernel in /boot
		mv Makefile Makefile.orig
		sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		    -e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
			Makefile.orig > Makefile || die "Cannot edit Makefile"
		rm Makefile.orig
		echo "-> Makefile patched"

		cd ${S}/include/rsbac
		# There is a definition missing, this patch resolve the problem - Quequero
		patch -p0 < ${FILESDIR}/nr_rsbac_patch.diff || die "can't patch syscall_rsbac.h"

}

src_compile() {
		einfo "Compile this kernel by yourself and good luck!"
}

src_install() {
		dodir /usr/src
		echo ">>> Copying sources..."
		mv ${WORKDIR}/linux* ${D}/usr/src
}

pkg_postinst() {
		rm -f ${ROOT}usr/src/linux
		ln -sf linux-${OKV}-rsbac ${ROOT}/usr/src/linux

		einfo "-> Kernel tree is OK"

		# We really need rsbac-admin otherwise it will be impossible to manage the new kernel permissions
		# but we can't install it before the kernel, rsbac-admin needs some headers included only in
		# the rsbac-kernel tree - Quequero
		einfo ">>> *** IMPORTANT *** <<<"
		einfo ">>> *** YOU MUST INSTALL sys-apps/rsbac-admin FOR MANAGING THIS KERNEL *** <<<"
}

