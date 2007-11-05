# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ipset/ipset-2.3.0.20070828.ebuild,v 1.2 2007/11/05 20:03:47 mr_bones_ Exp $

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

src_defs() {
	# these are used in both of src_compile and src_install
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/lib"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	myconf="${myconf} KERNEL_DIR=${WORKDIR}/patch-o-matic-ng/patchlets/set/linux-2.6"
	export myconf
}

src_compile() {
	src_defs
	emake CC="$(tc-getCC)" COPT_FLAGS="${CFLAGS}" ${myconf} || die "failed to build"
}

src_install() {
	src_defs
	emake DESTDIR="${D}" ${myconf} install || die "failed to package"
}

pkg_postinst() {
	elog "To use ${PN} you must have the ip_set kernel module compiled!"
	elog "To patch your kernel run:"
	elog
	elog " # emerge --config ipset"
	elog
	elog "And follow on-screen instructions."
}

pkg_config() {
	cd "${ROOT}${PORTAGE_TMPDIR}"
	mkdir patch-o-matic-ng
	cd patch-o-matic-ng

	IPTVERINS=`echo $(best_version net-firewall/iptables) | \
	sed -n 's:^[^/]*/[[:alpha:]]*-\([0-9]\+\([.][0-9]\+\)*[a-z]\?\(_\(pre\|p\|beta\|alpha\|rc\)[0-9]*\)*\)\(-r[0-9]\+\)\?$:\1:p'`

	einfo "Unpacking patch-o-matic-ng-${POM_PV}"
	tar -jxf "${DISTDIR}"/patch-o-matic-ng-${POM_PV}.tar.bz2 || \
				die "Unable to unpack patch-o-matic-ng-${POM_PV}"
	einfo "Unpacking iptables-${IPTVERINS}"
	tar -jxf "${DISTDIR}"/iptables-${IPTVERINS}.tar.bz2 || \
				die "Unable to unpack iptables-${IPTVERINS}.tar.bz2"

	cd patch-o-matic-ng
	einfo "Enter path to your kernel sources, relative to ${ROOT}"
	echo -n "[/usr/src/linux]: "
	read K_DIR
	[ "${ROOT}${K_DIR}" == "/" ] && K_DIR=${ROOT}/usr/src/linux
	if [ -d "${K_DIR}" ] ; then
		pwd
		einfo "Running KERNEL_DIR=${K_DIR} IPTABLES_DIR=../iptables-${IPTVERINS} ./runme set"
		KERNEL_DIR=${K_DIR} IPTABLES_DIR=../iptables-${IPTVERINS} ./runme set
	else
		eerror "${K_DIR} is not a directory"
	fi

	rm -rf "${ROOT}${PORTAGE_TMPDIR}"/patch-o-matic-ng
}
