# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/usermode-sources/usermode-sources-2.4.20-r2.ebuild,v 1.2 2004/01/07 10:17:03 plasmaroo Exp $
# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

# we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PV}
KV=${PVR}
UML_PATCH="uml-patch-${PV}-`echo ${PR}|sed -e 's:r\([0-9]\+\):\1:'`"
S=${WORKDIR}/linux-${KV}
EXTRAVERSION=${PR}

# What's in this kernel?

# INCLUDED:
#	User mode linux patch
#	http://user-mode-linux.sourceforge.net
#	UML clashes with the current Gentoo patch, so I've ignored it for now.

DESCRIPTION="Full (vanilla) sources for the User Mode Linux kernel"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
mirror://sourceforge/user-mode-linux/${UML_PATCH}.bz2"
HOMEPAGE="http://www.kernel.org/ http://user-mode-linux.sourceforge.net"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="x86 -ppc -sparc -alpha"

# console-tools is needed to solve the loadkeys fiasco.
# binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
DEPEND=">=sys-devel/binutils-2.11.90.0.31 dev-lang/perl"
RDEPEND=">=sys-libs/ncurses-5.2"

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {

	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux-${OKV} linux-${KV} || die
	cd ${S}
	bzcat ${DISTDIR}/${UML_PATCH}.bz2 | patch -d ${S} -p1

	epatch ${FILESDIR}/do_brk_fix.patch || die "Failed to patch do_brk() vulnerability!"
	epatch ${FILESDIR}/${PN}.CAN-2003-0985.patch || die "Failed to patch mremap() vulnerability!"
	epatch ${FILESDIR}/${P}.rtc_fix.patch || die "Failed to patch RTC vulnerabilities!"
	kernel_universal_unpack

	echo "Preparing for compilation..."

	# Fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *

}

src_compile() {
	ewarn "Nothing to compile.  That's up to the user"
}

src_install() {
		dodir /usr/src/uml
		cd ${S}
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src/uml
		cd ${D}/usr/src/uml
		ln -sf linux-${KV} linux
}
