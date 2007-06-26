# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-2.2.9.20070401.ebuild,v 1.2 2007/06/26 03:07:56 mr_bones_ Exp $

inherit eutils

MY_PV="${PV/2.2.9.}"
MY_P="${PN}-${MY_PV}"
MY_P_POM="patch-o-matic-ng-${MY_PV}"
DESCRIPTION="IPset userspace tool for iptables, successor to ippool."
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ftp.netfilter.org/pub/ipset/snapshot/${MY_P}.tar.bz2
	http://ftp.netfilter.org/pub/patch-o-matic-ng/snapshot/${MY_P_POM}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
RDEPEND=">=net-firewall/iptables-1.3"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${MY_P}"


src_defs() {
	# these are used in both of src_compile and src_install
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/lib"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	myconf="${myconf} KERNEL_DIR=${WORKDIR}/${MY_P_POM}/patchlets/set/linux-2.6"
	export myconf
}

src_compile() {
	src_defs
	emake COPT_FLAGS="${CFLAGS}" ${myconf} || die "failed to build"
}

src_install() {
	src_defs
	emake DESTDIR="${D}" ${myconf} install || die "failed to package"
}

pkg_postinst() {
	elog "To use ${PF} you must have the ip_set kernel module compiled!"
}
