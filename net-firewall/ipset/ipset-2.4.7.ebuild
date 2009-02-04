# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-2.4.7.ebuild,v 1.2 2009/02/04 21:42:48 maekke Exp $

inherit eutils versionator toolchain-funcs linux-mod linux-info

DESCRIPTION="IPset tool for iptables, successor to ippool."
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ipset.netfilter.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""
RDEPEND=">=net-firewall/iptables-1.4.1"
DEPEND="${RDEPEND}"

# configurable from outside
[ -z "${IP_NF_SET_MAX}" ] && IP_NF_SET_MAX=256
[ -z "${IP_NF_SET_HASHSIZE}" ] && IP_NF_SET_HASHSIZE=1024
BUILD_PARAMS="IP_NF_SET_MAX=$IP_NF_SET_MAX IP_NF_SET_HASHSIZE=${IP_NF_SET_HASHSIZE}"
# module fun
BUILD_TARGETS="all"
MODULE_NAMES_ARG="kernel/net/ipv4/netfilter:${S}/kernel"
MODULE_NAMES=""
for i in ip_set{,_{{ip,port,macip}map,{ip,net,ipport}hash,iptree{,map}}} \
	ipt_{SET,set}; do
	MODULE_NAMES="${MODULE_NAMES} ${i}(${MODULE_NAMES_ARG})"
done
# sanity
CONFIG_CHECK="NETFILTER"
ERROR_CFG="ipset needs netfilter support in your kernel."

src_unpack() {
	unpack ${A}
	sed -i \
		-e 's/KERNELDIR/(KERNELDIR)/g' \
		-e 's/^(\?KERNEL_\?DIR.*/KERNELDIR ?= /' \
		-e '/^all::/iV ?= 0' \
		-e '/^all::/iKBUILD_OUTPUT ?=' \
		-e '/$(MAKE)/{s/$@/ V=$(V) KBUILD_OUTPUT=$(KBUILD_OUTPUT) modules/}' \
		"${S}"/kernel/Makefile

	cd "${S}"
	epatch "${FILESDIR}/${P}-LDFLAGS.patch"
}

pkg_setup() {
	get_version

	modules=0
	msg=''
	if linux_chkconfig_builtin "MODULES" ; then
		modules=1
		msg="Modular kernel detected, will build kernel modules"
	else
		msg="Nonmodular kernel detected, will not build kernel modules"
	fi
	einfo "${msg}"

	[[ $modules -eq 1 ]] && \
		linux-mod_pkg_setup
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/$(get_libdir)"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	export myconf
}

src_compile() {
	einfo "Building userspace"
	emake CC="$(tc-getCC)" COPT_FLAGS="${CFLAGS}" ${myconf} binaries || die "failed to build"

	if [[ $modules -eq 1 ]]; then
		einfo "Building kernel modules"
		cd "${S}/kernel"
		export KERNELDIR="${KERNEL_DIR}"
		linux-mod_src_compile || die "failed to build modules"
	fi
}

src_install() {
	einfo "Installing userspace"
	emake DESTDIR="${D}" ${myconf} binaries_install || die "failed to package"

	if [[ $modules -eq 1 ]]; then
		einfo "Installing kernel modules"
		cd "${S}/kernel"
		export KERNELDIR="${KERNEL_DIR}"
		linux-mod_src_install
	fi
}
