# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/ppc-sources-dev/ppc-sources-dev-2.4.24-r2.ebuild,v 1.3 2004/04/17 19:03:26 aliz Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

# Included patches:
#  benh 2.4.24-0
#  pegasos 2.4.24-2
#  orinoco monitor 0.13
#  O_STREAMING 2.4.20-pre9-1
#  GRSecurity 2.0-rc4
#  ea+acl+nfsacl 0.8.65
#  XFS 2.4.23
#  Loop-Jari 2.4.22.0
#  FreeS/WAN 2.01
#  x509 1.4.5
#  Extra bootlogos

ETYPE="sources"
inherit kernel eutils
IUSE=""

OKV="2.4.24"
EXTRAVERSION="`echo ${PV}-${PR} | \
	sed -e 's/[0-9]\+\.[0-9]\+\.[0-9]\+\(.*\)/\1/'`"

KV=${PV}-ppc-dev-${PR}
S=${WORKDIR}/${PF}

inherit eutils

DESCRIPTION="Full sources for the linux kernel 2.4.24 with lots of extra features"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	 mirror://gentoo/patch-${KV/r2/r1}.patch.bz2"

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
	epatch ${DISTDIR}/patch-${KV/r2/r1}.patch.bz2
	epatch ${FILESDIR}/${P}.pmac_pmu.patch
	epatch ${FILESDIR}/${P}.munmap.patch || die "Failed to apply munmap patch!"

	cd ${WORKDIR}/${PF}
	MY_ARCH=${ARCH}
	EXTRAVERSION=-ppc-dev-${PR}
	unset ARCH
	kernel_universal_unpack
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
}
