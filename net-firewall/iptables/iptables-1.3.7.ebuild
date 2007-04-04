# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.3.7.ebuild,v 1.6 2007/04/04 12:55:29 gustavoz Exp $

inherit eutils flag-o-matic toolchain-funcs linux-info

L7_PV="2.9"
L7_P="netfilter-layer7-v${L7_PV}"
L7_PATCH="iptables-layer7-${L7_PV}.patch"
IMQ_PATCH="iptables-1.3.0-imq1.diff"

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/ http://www.linuximq.net/ http://l7-filter.sf.net/"
SRC_URI="http://iptables.org/projects/iptables/files/${P}.tar.bz2
	imq? ( http://www.linuximq.net/patchs/${IMQ_PATCH} )
	l7filter? ( mirror://sourceforge/l7-filter/${L7_P}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh sparc ~x86"
IUSE="extensions imq ipv6 l7filter static"

DEPEND="virtual/os-headers
	l7filter? ( virtual/linux-sources )
	imq? ( virtual/linux-sources )"
RDEPEND=""

pkg_setup() {
	if use l7filter || use imq || use extensions ; then
		ewarn "WARNING: 3rd party extensions has been enabled."
		ewarn "This means that iptables will use your currently installed"
		ewarn "kernel in ${KERNEL_DIR} as headers for iptables."
		ewarn
		if use extensions ; then
			ewarn "You may have to patch your kernel to allow iptables to build."
			ewarn "Please check http://ftp.netfilter.org/pub/patch-o-matic-ng/snapshot/ for patches"
			ewarn "for your kernel."
			ewarn
		fi
		linux-info_pkg_setup
	fi

	if use l7filter && \
		[ ! -f "${KERNEL_DIR}/net/ipv4/netfilter/ipt_layer7.c" ]; then
		die "For layer 7 support emerge net-misc/l7-filter-${L7_PV} before this"
	fi
	if use imq && \
		[ ! -f "${KERNEL_DIR}/net/ipv4/netfilter/ipt_IMQ.c" ]; then
		die "For IMQ support add a patch from http://www.linuximq.net/patches.html to your kernel"
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2
	use l7filter && unpack ${L7_P}.tar.gz
	cd "${S}"

	epatch "${FILESDIR}"/${P}-more-exact-check-grep.patch #159162
	epatch "${FILESDIR}"/${P}-sparc64.patch #166201

	EPATCH_OPTS="-p0" \
	epatch "${FILESDIR}"/1.3.1-files/install_ipv6_apps.patch
	EPATCH_OPTS="-p1" \
	epatch "${FILESDIR}"/1.3.1-files/install_all_dev_files.patch-1.3.1

	# this provide's grsec's stealth match
	EPATCH_OPTS="-p0" \
	epatch "${FILESDIR}"/1.3.1-files/grsecurity-1.2.8-iptables.patch-1.3.1
	sed -i \
		-e "s/PF_EXT_SLIB:=/PF_EXT_SLIB:=stealth /g" \
		extensions/Makefile || die "failed to enable stealth extension"

	EPATCH_OPTS="-p1" \
	epatch "${FILESDIR}"/1.3.1-files/${PN}-1.3.1-compilefix.patch

	if use imq ; then
		EPATCH_OPTS="-p1" epatch "${DISTDIR}"/${IMQ_PATCH}
		chmod +x extensions/{.IMQ-test*,.childlevel-test*}
	fi
	if use l7filter ; then
		EPATCH_OPTS="-p1" epatch "${WORKDIR}"/${L7_P}/${L7_PATCH}
		chmod +x extensions/.layer7-test*
	fi

	# the net directory is moving around so account for new/old locations
	cd "${S}"/extensions
	local x
	for x in .*-test* ; do
		sed -e 's:net/ipv[46]/netfilter:net/netfilter:g' ${x} > .new-${x}
		if cmp ${x} .new-${x} > /dev/null ; then
			rm -f .new-${x}
		else
			chmod a+rx .new-${x}
		fi
	done
}

src_defs() {
	# these are used in both of src_compile and src_install
	myconf=""
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/$(get_libdir)"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.
	use ipv6 || myconf="${myconf} DO_IPV6=0"
	use static && myconf="${myconf} NO_SHARED_LIBS=0"
	export myconf
	if ! use l7filter && ! use imq && ! use extensions ; then
		export KERNEL_DIR="/usr"
		diemsg="failure"
	else
		diemsg="failure - with l7filter or imq patch added"
	fi
	export diemsg
}

src_compile() {
	src_defs

	# iptables will NOT work correctly unless -O[123] are present!
	replace-flags -O0 -O2
	get-flag -O || append-flags -O2

	emake -j1 \
		COPT_FLAGS="${CFLAGS}" ${myconf} \
		KERNEL_DIR="${KERNEL_DIR}" \
		CC="$(tc-getCC)" \
		|| die "${diemsg}"
}

src_install() {
	src_defs
	make ${myconf} \
		DESTDIR="${D}" \
		KERNEL_DIR="${KERNEL_DIR}" \
		install install-devel || die "${diemsg}"

	dodir /usr/$(get_libdir)
	mv -f "${D}"/$(get_libdir)/*.a "${D}"/usr/$(get_libdir)

	keepdir /var/lib/iptables
	newinitd "${FILESDIR}"/${PN}-1.3.2.init iptables
	newconfd "${FILESDIR}"/${PN}-1.3.2.confd iptables

	if use ipv6 ; then
		keepdir /var/lib/ip6tables
		newinitd "${FILESDIR}"/iptables-1.3.2.init ip6tables
		newconfd "${FILESDIR}"/ip6tables-1.3.2.confd ip6tables
	fi
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	use ipv6 && einfo "and /var/lib/ip6tables/rules-save"
	einfo "This location can be changed in /etc/conf.d/iptables"
	einfo
	einfo "If you are using the iptables initsscript you should save your"
	einfo "rules using the new iptables version before rebooting."
	einfo
	einfo "If you are upgrading to a >=2.4.21 kernel you may need to rebuild"
	einfo "iptables."
	einfo
	ewarn "!!! ipforwarding is not a part of the iptables initscripts."
	einfo
	einfo "To enable ipforwarding at bootup:"
	einfo "/etc/sysctl.conf and set net.ipv4.ip_forward = 1"
	if use ipv6 ; then
		einfo "and/or"
		einfo "  net.ipv6.ip_forward = 1"
		einfo "for ipv6."
	fi
	if has_version '=net-firewall/iptables-1.2*' ; then
		echo
		ewarn "When upgrading from iptables-1.2.x, you may be unable to remove"
		ewarn "rules added with iptables-1.2.x.  This is a known issue, please see:"
		ewarn "http://bugs.gentoo.org/92535"
	fi
}
