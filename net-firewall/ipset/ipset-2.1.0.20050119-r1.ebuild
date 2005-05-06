# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-2.1.0.20050119-r1.ebuild,v 1.2 2005/05/06 14:34:48 swegener Exp $

inherit eutils flag-o-matic versionator linux-info

MY_PV="$(replace_version_separator 3 '-' )"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="IPset tool for iptables, successor to ippool."
HOMEPAGE="http://people.netfilter.org/kadlec/ipset/"
SRC_URI="${HOMEPAGE}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND=">=net-firewall/iptables-1.3"
DEPEND="${RDEPEND}
		virtual/linux-sources"
S="${WORKDIR}/${PN}"
CONFIG_CHECK="IP_NF_SET"

pkg_setup() {
	ewarn "If your kernel sources do not contain the IPset functionality,"
	ewarn "this package may fail to compile."
	linux-info_pkg_setup
}

src_defs() {
	# these are used in both of src_compile and src_install
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/lib"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	export myconf
}

src_compile() {
	src_defs

	# for some reason, it doesn't behave right if this is skipped
	replace-flags -O0 -O2
	if [ -z `get-flag O` ]; then
		append-flags -O2
	fi

	# see iptables ebuild, as this code links against it
	filter-flags "-fstack-protector"

	# now build it
	emake COPT_FLAGS="${CFLAGS}" ${myconf} \
		KERNEL_DIR="${KERNEL_DIR}" \
		|| die "failed to build"
}

src_install() {
	src_defs
	emake DESTDIR="${D}" ${myconf} \
		KERNEL_DIR="${KERNEL_DIR}" \
		install || die "failed to package"
}
