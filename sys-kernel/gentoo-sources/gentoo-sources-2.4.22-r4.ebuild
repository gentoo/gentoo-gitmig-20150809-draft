# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-2.4.22-r4.ebuild,v 1.4 2004/02/18 08:17:18 iggy Exp $

# OKV=original kernel version, KV=patched kernel version.  They can be the same.

ETYPE="sources"

inherit kernel
OKV="`echo ${PV}|sed -e 's:^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*:\1:'`"
EXTRAVERSION="-${PN/-*/}"
[ ! "${PR}" == "r0" ] && EXTRAVERSION="${EXTRAVERSION}-${PR}"
KV="${OKV}${EXTRAVERSION}"

S=${WORKDIR}/linux-${KV}

# Documentation on the patches contained in this kernel will be installed
# to /usr/share/doc/gentoo-sources-${PV}/patches.txt.gz

DESCRIPTION="Full sources for the Gentoo Kernel."
SRC_URI="mirror://kernel/linux/kernel/v2.4/linux-${OKV}.tar.bz2
	http://dev.gentoo.org/~iggy/${PF}.patch.bz2"
HOMEPAGE="http://www.gentoo.org/ http://www.kernel.org/"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -alpha -hppa -mips -arm -amd64 -ia64"
SLOT="${KV}"

src_unpack() {
	unpack ${A}

	mv linux-${OKV} linux-${KV} \
		|| die "Error moving kernel source tree to linux-${KV}"

	cd linux-${KV}

	epatch ${DISTDIR}/${PF}.patch.bz2 \
		|| die "Failed to patch kernel"

	cd ${S}
	sed -e '34s/#//' -i net/ipsec/Config.in
	sed -e '13s/^/#/' -i net/ipsec/alg/Config.in

	kernel_universal_unpack
}

pkg_postinst() {
	kernel_pkg_postinst

	echo
	ewarn "If iptables/netfilter behaves abnormally, such as 'Invalid Argument',"
	ewarn "you will need to re-emerge iptables to restore proper functionality."
	echo
	einfo "If there are issues with this kernel, search http://bugs.gentoo.org/ for an"
	einfo "existing bug. Only create a new bug if you have not found one that matches"
	einfo "your issue. It is best to do an advanced search as the initial search has a"
	einfo "very low yield. Please assign your bugs to x86-kernel@gentoo.org."
	echo
	einfo "Please read the ChangeLog and associated docs for more information."
}
