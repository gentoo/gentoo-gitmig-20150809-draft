# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-0.9.1.ebuild,v 1.3 2004/12/02 11:38:54 dragonheart Exp $

inherit kernel-mod eutils

MY_P=netfilter-layer7-v${PV}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz
	mirror://sourceforge/l7-filter/kernel-2.6-layer7-${PV}+working_with_2.6.9.patch"
LICENSE="GPL-2"
SLOT="${KV}"
KEYWORDS="x86 ~ppc"
IUSE=""

S=${WORKDIR}/${MY_P}
DEPEND=""

src_unpack() {

	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code. (${KV_OUTPUT})"
	ewarn "Its up to you to recompile the kernel with the l7 options"

	unpack ${MY_P}.tar.gz

	kernel-mod_getversion

	cd ${S}

	mkdir  kernel
	mkdir  kernel/Documentation


	local PATCH
	if kernel-mod_is_2_4_kernel
	then
		PATCH=${S}/kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
	else
		if [ "${KV_PATCH}" -ge 9 ]
		then
			PATCH=${DISTDIR}/kernel-2.6-layer7-${PV}+working_with_2.6.9.patch
		else
			PATCH=${S}/kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
		fi
	fi

	if [ ! -f ${PATCH} ];
	then
		die "Kernel version ${KV_VERSION_FULL} no supported"
	fi

	# create needed directories
	mkdir -p ${S}/kernel/net/ipv4/netfilter/regexp/
	mkdir -p ${S}/kernel/include/linux/netfilter_ipv4/

	cd ${KERNEL_DIR}


	# start to copy needed files, if file not exists create an empty file
	FILES=$(patch -t --dry-run -p1 < ${PATCH} | grep "^patching file" | cut -f 3 -d ' ')
	for F in ${FILES};
	do
		if [ -f ${F} ];
		then
			cp -P ${F} ${S}/kernel/${F}
		else
			touch ${S}/kernel/${F}
		fi
	done

	#patch the copied kernel source
	cd ${S}/kernel
	epatch ${PATCH} || die "Failed to apply patch"
}

src_compile() {
	einfo "no compiling - just patching source"
}

src_install() {
	dodir ${KERNEL_DIR}
	cp -a kernel/* ${D}/${KERNEL_DIR}
}


pkg_postinst() {
	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code (${KERNEL_DIR})"
}
