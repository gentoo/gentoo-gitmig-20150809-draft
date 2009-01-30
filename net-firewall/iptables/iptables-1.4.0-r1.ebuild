# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.4.0-r1.ebuild,v 1.15 2009/01/30 21:54:08 dragonheart Exp $

inherit eutils toolchain-funcs linux-info

L7_PV=2.21
L7_P=netfilter-layer7-v${L7_PV}
IMQ_PATCH=iptables-1.4.0-imq.diff

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/ http://www.linuximq.net/ http://l7-filter.sf.net/"
SRC_URI="http://iptables.org/projects/iptables/files/${P}.tar.bz2
	imq? ( http://www.actusa.net/~linuximq/${IMQ_PATCH} )
	l7filter? ( mirror://sourceforge/l7-filter/${L7_P}.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86"
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

	if use l7filter ; then
		if kernel_is lt 2 6 20 ; then
			eerror "Currently there is no l7-filter patch available for iptables-1.4.x"
			eerror "and kernel version before 2.6.20."
			eerror "If you need to compile iptables 1.4.x against Linux 2.6.19.x"
			eerror "or earlier, with l7-filter patch, please, report upstream."
			die "No patch available."
		fi
		[ ! -f "${KERNEL_DIR}/include/linux/netfilter/xt_layer7.h" ] && \
			die "For layer 7 support emerge net-misc/l7-filter-${L7_PV} before this."
	fi
	if use imq && \
		[ ! -f "${KERNEL_DIR}/net/ipv4/netfilter/ipt_IMQ.c" ]; then
			eerror "For IMQ support add a patch from http://www.actusa.net/~linuximq/ or from"
			eerror "http://www.linuximq.net/patches.html (for older kernels) to your kernel."
			die "Please, patch your kernel to support IMQ."
	fi
}

src_unpack() {
	unpack ${P}.tar.bz2
	if use l7filter ; then
		unpack ${L7_P}.tar.gz
	fi
	cd "${S}"

	epatch "${FILESDIR}"/${P}-dev-files.patch
	epatch "${FILESDIR}"/${P}-in6-glibc-2.8.patch #225505
	epatch "${FILESDIR}"/${P}-2.6.26-kernel.patch #246395

	# this provide's grsec's stealth match
	EPATCH_OPTS="-p0" \
	epatch "${FILESDIR}"/1.3.1-files/grsecurity-1.2.8-iptables.patch-1.3.1
	sed -i \
		-e "s/PF_EXT_SLIB:=/PF_EXT_SLIB:=stealth /g" \
		extensions/Makefile || die "failed to enable stealth extension"

	local check base=${PORTAGE_CONFIGROOT}/etc/portage/patches
	for check in {${CATEGORY}/${PF},${CATEGORY}/${P},${CATEGORY}/${PN}}; do
		EPATCH_SOURCE=${base}/${CTARGET}/${check}
		[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${base}/${CHOST}/${check}
		[[ -r ${EPATCH_SOURCE} ]] || EPATCH_SOURCE=${base}/${check}
		if [[ -d ${EPATCH_SOURCE} ]] ; then
			EPATCH_SUFFIX="patch"
			EPATCH_FORCE="yes" \
			EPATCH_MULTI_MSG="Applying user patches from ${EPATCH_SOURCE} ..." \
			epatch
			break
		fi
	done

	if use imq ; then
		EPATCH_OPTS="-p1" epatch "${DISTDIR}"/${IMQ_PATCH}
		chmod +x extensions/.IMQ-test*
	fi

	if use l7filter ; then
		EPATCH_OPTS="-p1" epatch \
			"${WORKDIR}"/${L7_P}/iptables-1.4-for-kernel-2.6.20forward-layer7-${L7_PV}.patch
		chmod +x extensions/.layer7-test
	fi

	if ! use extensions ; then
		cat <<-EOF > "${S}"/include/linux/compiler.h
		#define __user
		EOF
	fi
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
		export KERNEL_DIR=$(
			# ugh -- iptables has scripts which check for the existence of
			# files so we need to give it the right path to our toolchains
			# include dir where the linux headers are.
			# FYI IPTABLES: YOU FAIL
			echo '#include <linux/limits.h>' | $(tc-getCPP) - | grep -o '/[^"]*linux/limits.h' | sed s:/include/linux/limits.h::
		)
		export KBUILD_OUTPUT=${KERNEL_DIR}
		diemsg="failure"
	else
		export KERNEL_DIR
		diemsg="failure - with l7filter and/or imq patch and/or other miscellanious patches added"
	fi
	export diemsg
}

src_compile() {
	src_defs
	emake \
		COPT_FLAGS="${CFLAGS}" ${myconf} \
		CC="$(tc-getCC)" \
		|| die "${diemsg}"
}

src_install() {
	src_defs
	emake ${myconf} \
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
	elog "This package now includes an initscript which loads and saves"
	elog "rules stored in /var/lib/iptables/rules-save"
	use ipv6 && elog "and /var/lib/ip6tables/rules-save"
	elog "This location can be changed in /etc/conf.d/iptables"
	elog
	elog "If you are using the iptables initsscript you should save your"
	elog "rules using the new iptables version before rebooting."
	elog
	elog "If you are upgrading to a >=2.4.21 kernel you may need to rebuild"
	elog "iptables."
	elog
	ewarn "!!! ipforwarding is not a part of the iptables initscripts."
	ewarn
	ewarn "To enable ipforwarding at bootup:"
	ewarn "/etc/sysctl.conf and set net.ipv4.ip_forward = 1"
	if use ipv6 ; then
		ewarn "and/or"
		ewarn "  net.ipv6.ip_forward = 1"
		ewarn "for ipv6."
	fi
}
