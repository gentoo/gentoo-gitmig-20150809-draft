# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-1.4.ebuild,v 1.5 2005/08/20 04:37:19 dragonheart Exp $

inherit linux-info eutils

MY_P=netfilter-layer7-v${PV}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz
	mirror://sourceforge/l7-filter/additional_patch_for_2.6.13.diff"

LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE=""
SLOT="${KV}"
S=${WORKDIR}/${MY_P}
RDEPEND="net-misc/l7-protocols"

src_unpack() {

	pkg_postinst

	if [ -f ${KV_DIR}/include/linux/netfilter_ipv4/ipt_layer7.h ]
	then
		ewarn "already installed ${PF} for kernel ${KV_FULL}"
		return 0;
	fi

	unpack ${MY_P}.tar.gz

	cd ${S}

	mkdir  kernel
	mkdir  kernel/Documentation


	local PATCH
	if kernel_is 2 4
	then
		PATCH=kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
	elif kernel_is ge 2 6 9
	then
		if kernel_is ge 2 6 11
		then
			PATCH=kernel-2.6.11-layer7-${PV}.patch
		else
			PATCH=for_older_kernels/kernel-2.6.9-2.6.10-layer7-1.2.patch
		fi
	else
		# 2.6.0-2.6.8.1
		PATCH=for_older_kernels/kernel-2.6.0-2.6.8.1-layer7-0.9.2.patch
	fi

	if [ ! -f ${PATCH} ];
	then
		die "Patch ${PATCH} fpr Kernel version ${KV_FULL} not supported"
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

	# bug #102813
	if kernel_is ge 2 6 11
	then
		epatch ${DISTDIR}/additional_patch_for_2.6.13.diff
	fi
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

