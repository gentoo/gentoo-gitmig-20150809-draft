# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-filter/l7-filter-0.9.1.ebuild,v 1.2 2004/08/28 15:27:08 dholm Exp $

inherit kmod eutils

MY_P=netfilter-layer7-v${PV}
DESCRIPTION="Kernel modules for layer 7 iptables filtering"
HOMEPAGE="http://l7-filter.sourceforge.net"
SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"
RESTRICT="nomirror"
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

	# Unpack and set some variables
	kmod_src_unpack

	cd ${S}
	PATCH=kernel-${KV_MAJOR}.${KV_MINOR}-layer7-${PV}.patch
	if [ ! -f ${PATCH} ];
	then
		die "Kernel version ${KV_VERSION_FULL} no supported"
	fi

	# create needed directories
	mkdir -p ${S}/kernel/net/ipv4/netfilter/regexp/
	mkdir -p ${S}/kernel/include/linux/netfilter_ipv4/

	cd ${KV_OUTPUT}


	# start to copy needed files, if file not exists create an empty file
	FILES=$(patch -t --dry-run -p1 < ${S}/${PATCH} | cut -f 3 -d ' ')
	for F in ${FILES};
	do
		if [ -f ${F} ];
		then
			cp -P ${F} ${S}/kernel/${F}
		else
			touch ${S}/kernel/${F}
		fi
	done

}

src_compile() {
	#patch the copied kernel source
	cd ${S}/kernel
	epatch ${S}/${PATCH} || die "Failed to apply patch"
}

src_install() {
	dodir ${KV_OUTPUT}
	cp -a kernel/* ${D}/${KV_OUTPUT}
}


pkg_postinst() {
	ewarn "This may not work with all kernels."
	ewarn "This only patches the current kernel source code (${KV_OUTPUT})"
	ewarn "To change this kernel see http://www.gentoo.org/doc/en/2.6-koutput-user.xml"
	ewarn "Its up to you to recompile the kernel with the l7 options"
}
