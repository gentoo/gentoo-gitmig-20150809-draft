# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.23_p3.ebuild,v 1.1 2005/01/12 00:19:37 vapier Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="headers"
inherit kernel
OKV="${PV/_p*/}"
PATCH_LEVEL="${PV/${OKV}_p/}"
KV=${OKV}-pa${PATCH_LEVEL}
EXTRAVERSION="-pa${PATCH_LEVEL}"
S=${WORKDIR}/linux-${KV}
IUSE=""

DESCRIPTION="Full sources for the Linux kernel with patch for hppa"
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2 http://ftp.parisc-linux.org/cvs/linux-2.4/patch-${OKV}-pa${PATCH_LEVEL}.gz"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/ http://parisc-linux.org"
KEYWORDS="-* hppa"
SLOT="0"

src_unpack() {
	unpack linux-${OKV}.tar.bz2
	mv ${WORKDIR}/linux-${OKV} ${WORKDIR}/linux-${KV}
	cd ${S}

	einfo Applying ${OKV}-pa`echo ${PATCH_LEVEL} | awk '{ print $1 }'`
	zcat ${DISTDIR}/patch-${OKV}-pa`echo ${PATCH_LEVEL} | awk '{ print $1 }'`.gz | patch -sp 1


	#make sure our sources are clean
	make mrproper

	kernel_universal_unpack
}


src_compile() {

	yes "" | make oldconfig
	echo "Ignore any errors from the yes command above."
	make archdep

}
