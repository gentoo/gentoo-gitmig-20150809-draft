# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.3.1-r1.ebuild,v 1.1 2005/03/23 10:23:36 dragonheart Exp $

inherit eutils flag-o-matic

#extensions versions

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="ipv6 static extensions"

DEPEND="virtual/os-headers
		extensions? ( virtual/linux-sources )"
RDEPEND=""

L7_PN="netfilter-layer7"
L7_PV="1.1"
L7_P="${L7_PN}-v${L7_PV}"
L7_PATCH="iptables-layer7-${L7_PV}.patch"
IMQ_PATCH="iptables-1.3.0-imq1.diff"

SRC_URI="http://www.iptables.org/files/${P}.tar.bz2
		extensions? (
			http://www.linuximq.net/patchs/${IMQ_PATCH}
			mirror://sourceforge/l7-filter/${L7_P}.tar.gz
		)"

pkg_setup() {
	if use extensions; then
		einfo "WARNING: 3rd party extensions has been enabled."
		einfo "This means that iptables will use your currently installed"
		einfo "kernel in /usr/src/linux as headers for iptables."
		einfo ""
		einfo "You may have to patch your kernel to allow iptables to build."
		einfo "Please check http://ftp.netfilter.org/pub/patch-o-matic-ng/snapshot/ for patches"
		einfo "for your kernel."
		einfo ""
		einfo "For layer 7 support emerge net-misc/l7-filter-${L7_PV} before this"
	fi
}


src_unpack() {
	unpack ${P}.tar.bz2 ${L7_P}.tar.gz ; cd ${S}

	EPATCH_OPTS="-p0" \
	epatch ${FILESDIR}/${PV}-files/install_ipv6_apps.patch.bz2
	EPATCH_OPTS="-p1" \
	epatch ${FILESDIR}/${PV}-files/install_all_dev_files.patch-${PV}.bz2

	# Both of these have been merged upstream
	# EPATCH_OPTS="-p1" epatch ${FILESDIR}/${PV}-files/round-robin.patch
	# security bug 70240
	# EPATCH_OPTS="-p2" epatch ${FILESDIR}/${PV}-files/CAN-2004-0986.patch

	# this provide's grsec's stealth match
	EPATCH_OPTS="-p0" \
	epatch ${FILESDIR}/${PV}-files/grsecurity-1.2.8-iptables.patch-${PV}.bz2
	sed -i "s/PF_EXT_SLIB:=/PF_EXT_SLIB:=stealth /g" extensions/Makefile

	EPATCH_OPTS="-p1" \
	epatch ${FILESDIR}/${PV}-files/${P}-compilefix.patch

	if use extensions; then
		EPATCH_OPTS="-p1" epatch ${DISTDIR}/${IMQ_PATCH}
		EPATCH_OPTS="-p1" epatch ${WORKDIR}/${L7_P}/${L7_PATCH}
		chmod +x extensions/{.IMQ-test*,.childlevel-test*,.layer7-test*}
	fi
}


src_defs() {
	# these are used in both of src_compile and src_install
	myconf="${myconf} PREFIX="
	myconf="${myconf} LIBDIR=/lib"
	myconf="${myconf} BINDIR=/sbin"
	myconf="${myconf} MANDIR=/usr/share/man"
	myconf="${myconf} INCDIR=/usr/include"
	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.
	use ipv6 || myconf="${myconf} DO_IPV6=0"
	use static && myconf="${myconf} NO_SHARED_LIBS=0"
	export myconf
	diemsg="Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
	export diemsg
}


src_compile() {
	src_defs
	replace-flags -O0 -O2

	if [ -z `get-flag O` ]; then
		append-flags -O2
	fi

	# prevent it from causing ICMP errors.
	# http://bugs.gentoo.org/show_bug.cgi?id=23645
	filter-flags "-fstack-protector"


	if use extensions; then
		# Only check_KV if /usr/src/linux exists
		if [ -L ${ROOT}/usr/src/linux -o -d ${ROOT}/usr/src/linux ]; then
			check_KV
		else
			ewarn "You don't have kernel sources available at /usr/src/linux."
			ewarn "Iptables will be built against linux-headers."
		fi

		make COPT_FLAGS="${CFLAGS}" ${myconf} \
			KERNEL_DIR=/usr/src/linux \
			|| die "${diemsg}"
	else
		make COPT_FLAGS="${CFLAGS}" ${myconf} \
			KERNEL_DIR=/usr \
			|| die
	fi
}

src_install() {
	src_defs
	myconf="DESTDIR=${D} ${myconf}"
	if use extensions; then
		make ${myconf} \
			KERNEL_DIR=/usr/src/linux \
			install || die "${diemsg}"

		make ${myconf} \
			KERNEL_DIR=/usr/src/linux \
			install-devel || die "${diemsg}"
	else
		make ${myconf} \
			KERNEL_DIR=/usr \
			install || die

		make ${myconf} \
			KERNEL_DIR=/usr \
			install-devel || die
	fi

	dodoc COPYING
	keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}-1.2.9-r1.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/${PN}-1.2.9-r1.confd iptables

	if use ipv6; then
		keepdir /var/lib/ip6tables
		exeinto /etc/init.d
		newexe ${FILESDIR}/${PN/iptables/ip6tables}-1.2.9-r1.init ip6tables
		insinto /etc/conf.d
		newins ${FILESDIR}/${PN/iptables/ip6tables}-1.2.9-r1.confd ip6tables
	fi
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	useq ipv6 >/dev/null && einfo "and /var/lib/ip6tables/rules-save"
	einfo "This location can be changed in /etc/conf.d/iptables"
	einfo ""
	einfo "If you are using the iptables initsscript you should save your"
	einfo "rules using the new iptables version before rebooting."
	einfo ""
	einfo "If you are upgrading to a >=2.4.21 kernel you may need to rebuild"
	einfo "iptables."
	einfo ""
	ewarn "!!! ipforwarding is now not a part of the iptables initscripts."
	einfo "Until a more permanent solution is implemented adding the following"
	einfo "to /etc/conf.d/local.start will enable ipforwarding at bootup:"
	einfo "  echo \"1\" > /proc/sys/net/ipv4/conf/all/forwarding"
	if useq ipv6; then
		einfo "and/or"
		einfo "  echo \"1\" > /proc/sys/net/ipv6/conf/all/forwarding"
		einfo "for ipv6."
	fi
}
