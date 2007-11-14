# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-2.3.0.20070828-r2.ebuild,v 1.1 2007/11/14 05:50:21 pva Exp $

inherit eutils versionator toolchain-funcs

POM_PV="20071021"

MY_PV=$(replace_version_separator 3 -)
DESCRIPTION="IPset userspace tool for iptables, successor to ippool."
HOMEPAGE="http://ipset.netfilter.org/"
SRC_URI="http://ipset.netfilter.org/${PN}-${MY_PV}.tar.bz2
		http://ipset.netfilter.org/patch-o-matic-ng-${POM_PV}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE=""
RDEPEND=">=net-firewall/iptables-1.3"
DEPEND="${RDEPEND}"
S=${WORKDIR}/ipset-${MY_PV%-*}

pkg_setup() {
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/$(get_libdir)"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	myconf="${myconf} KERNEL_DIR=${WORKDIR}/patch-o-matic-ng/patchlets/set/linux-2.6"
}

src_compile() {
	emake CC="$(tc-getCC)" COPT_FLAGS="${CFLAGS}" ${myconf} || die "failed to build"
}

src_install() {
	emake DESTDIR="${D}" ${myconf} install || die "failed to package"
}

pkg_postinst() {
	elog "To use ${PN} you must have the ip_set kernel module compiled!"
	elog "To patch you kernel run:"
	elog
	elog " # emerge --config ipset"
	elog
	elog "And follow on-screen instructions"
}

pkg_config() {
	cd "${ROOT}${PORTAGE_TMPDIR}"
	[ -d patch-o-matic-ng ] && {
		einfo "${ROOT}${PORTAGE_TMPDIR}/patch-o-matic-ng directory exist. Cleaning it..." ;
		rm -rf patch-o-matic-ng;
	}
	mkdir patch-o-matic-ng && cd patch-o-matic-ng

	IPTVERINS=`echo $(best_version net-firewall/iptables) | \
	sed -n 's:^[^/]*/[[:alpha:]]*-\([0-9]\+\([.][0-9]\+\)*[a-z]\?\(_\(pre\|p\|beta\|alpha\|rc\)[0-9]*\)*\)\(-r[0-9]\+\)\?$:\1:p'`

	einfo "Unpacking patch-o-matic-ng-${POM_PV} and iptables-${IPTVERINS} sources"
	unpack {patch-o-matic-ng-${POM_PV},iptables-${IPTVERINS}}.tar.bz2

	einfo "I'm going to patch sources in ${ROOT}usr/src/linux"
	cd patch-o-matic-ng
	KERNEL_DIR="${ROOT}"usr/src/linux IPTABLES_DIR=../iptables-${IPTVERINS} ./runme set

	einfo "Cleaning ${ROOT}${PORTAGE_TMPDIR}/patch-o-matic-ng directory"
	rm -rf "${ROOT}${PORTAGE_TMPDIR}"/patch-o-matic-ng
}
