# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources/ppc-sources-2.4.24.ebuild,v 1.1 2004/01/14 08:47:02 trance Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"
inherit kernel

OKV="2.4.24"

EXTRAVERSION="`echo ${PV}-${PR/r/benh} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${PV}-${PR/r/benh}

S=${WORKDIR}/linux-${KV}

inherit eutils


DESCRIPTION="Full sources for the linux kernel 2.6 with benh's patchset"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
		mirror://gentoo/patch-${KV}.bz2
		http://dev.gentoo.org/~trance/stuff/patch-${KV}.bz2"

KEYWORDS="~ppc -ppc64"
DEPEND=">=sys-devel/binutils-2.11.90.0.31"
RDEPEND=">=sys-libs/ncurses-5.2 dev-lang/perl virtual/modutils sys-devel/make"

SLOT=${KV}
PROVIDE="virtual/linux-sources"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2

	mv linux-${OKV} ${PF}
	cd ${PF}
	bzcat ${DISTDIR}/patches-${KV}.bz2 | patch -p1 || die "patch failed"
	find . -iname "*~" | xargs rm 2> /dev/null

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	# also fix the EXTRAVERSION
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		-e "s:^\(EXTRAVERSION =\).*:\1 ${EXTRAVERSION}:" \
			Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig

	cd ${WORKDIR}/${PF}
	MY_ARCH=${ARCH}
	unset ARCH
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die "make mrproper died"
	ARCH=${MY_ARCH}

}

src_install() {
	dodir /usr/src
	echo ">>> Copying sources..."
	mv ${WORKDIR}/* ${D}/usr/src
}
pkg_postinst() {
	if [ ! -e ${ROOT}usr/src/linux ]
	then
		ln -sf ${PF} ${ROOT}/usr/src/linux
	fi

	ewarn "XFS file system support is not included in this kernel"
	echo
}
