# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-1.1.ebuild,v 1.3 2005/03/23 10:20:49 dragonheart Exp $

inherit linux-info eutils

MY_P=netfilter-layer7-v${PV}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
IUSE=""
SLOT="${KV}"
S=${WORKDIR}/${MY_P}
DEPEND=""

src_unpack() {

	pkg_postinst

	unpack ${A}

	cd ${S}

	mkdir  kernel
	mkdir  kernel/Documentation


	local PATCH
	if kernel_is 2 4
	then
		PATCH=for_older_kernels/kernel-${KV_MAJOR}.${KV_MINOR}-layer7-0.9.1.patch
	elif kernel_is ge 2 6 9
	then
		if kernel_is ge 2 6 11
		then
			PATCH=kernel-2.6.11-layer7-${PV}.patch
		else
			PATCH=for_older_kernels/kernel-2.6.9-2.6.10-layer7-${PV}.patch
		fi
	else
		# 2.6.0-2.6.8.1
		PATCH=for_older_kernels/kernel-2.6.0-2.6.8.1-layer7-0.9.1.patch
	fi

	if [ ! -f ${PATCH} ];
	then
		die "Kernel version ${KV_FULL} not supported"
	fi

	# create needed directories
	mkdir -p ${S}/kernel/net/ipv4/netfilter/regexp/
	mkdir -p ${S}/kernel/include/linux/netfilter_ipv4/

	cd ${KV_DIR}


	# start to copy needed files, if file not exists create an empty file
	FILES=$(patch -t --dry-run -p1 < ${S}/${PATCH} | grep "^patching file" | cut -f 3 -d ' ')
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
	epatch ${S}/${PATCH}
}

src_compile() {
	einfo "no compiling - just patching source"
}

src_install() {
	insinto ${KV_DIR}
	doins -r kernel/*
	dodoc CHANGELOG README
}


pkg_postinst() {
	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code. (${KV_DIR})"
	ewarn "Its up to you to recompile the kernel with the l7 options"
	ewarn
	ewarn 'You will also need to emerge iptables with the "extensions" USE flag'
}

