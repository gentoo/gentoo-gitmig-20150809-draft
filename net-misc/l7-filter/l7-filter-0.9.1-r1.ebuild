# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-0.9.1-r1.ebuild,v 1.2 2005/01/04 09:31:33 dragonheart Exp $

inherit linux-info eutils

MY_P=netfilter-layer7-v${PV}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz
	mirror://sourceforge/l7-filter/kernel-2.6-layer7-${PV}+working_with_2.6.9.patch
	mirror://gentoo/kernel-2.6-layer7-0.9.1+working_with_2.6.10.patch"

# 2.6.10 patch from
# http://sourceforge.net/tracker/download.php?group_id=80085&atid=558670&file_id=113753&aid=1092484

LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""
SLOT="${KV}"
S=${WORKDIR}/${MY_P}
DEPEND=""

src_unpack() {

	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code. (${KV_DIR})"
	ewarn "Its up to you to recompile the kernel with the l7 options"

	unpack ${MY_P}.tar.gz

	cd ${S}

	mkdir  kernel
	mkdir  kernel/Documentation


	local PATCH
	if kernel_is 2 4
	then
		PATCH=${S}/kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
	elif kernel_is 2 6 9
	then
		PATCH=${DISTDIR}/kernel-2.6-layer7-${PV}+working_with_2.6.9.patch
	elif kernel_is ge 2 6 10
	then
		PATCH=${DISTDIR}/kernel-2.6-layer7-0.9.1+working_with_2.6.10.patch
	else
		PATCH=${S}/kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
	fi

	if [ ! -f ${PATCH} ];
	then
		die "Kernel version ${KV_FULL} no supported"
	fi

	# create needed directories
	mkdir -p ${S}/kernel/net/ipv4/netfilter/regexp/
	mkdir -p ${S}/kernel/include/linux/netfilter_ipv4/

	cd ${KV_DIR}


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
	dodir ${KV_DIR}
	cp -a kernel/* ${D}/${KV_DIR}
	chown -R root:root ${D}
}


pkg_postinst() {
	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code (${KV_DIR})"
}
