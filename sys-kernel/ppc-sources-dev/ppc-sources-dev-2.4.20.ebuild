# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-dev/ppc-sources-dev-2.4.20.ebuild,v 1.15 2004/01/08 21:30:08 plasmaroo Exp $

#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=${PVR}
KV=2.4.20-r8
S=${WORKDIR}/linux-${KV}
ETYPE="sources"


# What's in this kernel?

# INCLUDED:
#	2.4.20-pre1-benh
#	latest SunGEM driver with ibook fixes
#	Ani Joshi's rivafb bigendian fixes from YDL


DESCRIPTION="Full developmental sources for the Gentoo Linux PPC kernel - Experimental!"
SRC_URI="http://www.penguinppc.org/~kevyn/kernels/gentoo/linux-${KV}.tar.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="~ppc -x86 -sparc "

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl sys-devel/make"
fi


src_unpack() {
	cd ${WORKDIR}
	unpack linux-${KV}.tar.bz2
	cd ${S}
	pwd

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0:0 *
	chmod -R a+r-w+X,u+w *

}

src_install() {
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		cd ${S}
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
		make dep
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-ppc/* ${D}/usr/include/asm
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

	einfo "* Warning * - This is an experimental kernel to test features"
	einfo " before they make it to ppc-sources. This is a use at your own"
	einfo " risk kernel for the devs and tester to try."
	einfo " If it eats your computer, You have been warned. =)"
	einfo " "
	einfo " Please submit successes or failures via http://bugs.gentoo.org"
	einfo " and assign the bug to trance@gentoo.org. Thank you."
}
