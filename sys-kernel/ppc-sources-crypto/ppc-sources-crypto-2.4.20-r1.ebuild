# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-crypto/ppc-sources-crypto-2.4.20-r1.ebuild,v 1.2 2003/12/14 23:43:09 spider Exp $

IUSE="build crypt"

# OKV=original kernel version, KV=patched kernel version.  They can be the same.
OKV=2.4.20
KV=2.4.20
S=${WORKDIR}/linux-ppc-crypto-${KV}

# Kernel ebuilds using the kernel.eclass can remove any patch that you
# do not want to apply by simply setting the KERNEL_EXCLUDE shell
# variable to the string you want to exclude (for instance
# KERNEL_EXCLUDE="evms" would not patch any patches whose names match
# *evms*).  Kernels are only tested in the default configuration, but
# this may be useful if you know that a particular patch is causing a
# conflict with a patch you personally want to apply, or some other
# similar situation.

ETYPE="sources"

#inherit kernel

DESCRIPTION="Full cryptoapi enabled sources for the Gentoo Linux PPC kernel"
SRC_URI="http://perso.wanadoo.fr/olivier.reisch/linux-ppc-crypto/linux-ppc-crypto-${OKV}.tar.bz2"
KEYWORDS="-x86 ppc -sparc -alpha"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.kerneli.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="${KV}"

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl
		virtual/modutils sys-devel/make"
fi


src_unpack() {

	cd ${WORKDIR}
	unpack linux-ppc-crypto-${OKV}.tar.bz2
	cd ${S}
	pwd

	epatch ${FILESDIR}/do_brk_fix.patch || die "failed to patch for do_brk vuln"

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
		ln -sf linux-ppc-crypto-${KV} ${ROOT}/usr/src/linux
	fi
	[ `use xfs` ] && ewarn "XFS is no longer included!"
}
