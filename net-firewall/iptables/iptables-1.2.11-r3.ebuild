# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.2.11-r3.ebuild,v 1.2 2004/11/07 23:18:06 kumba Exp $

inherit eutils flag-o-matic

#extensions versions

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~ppc64"
IUSE="ipv6 static extensions"

DEPEND="virtual/os-headers
	extensions? ( virtual/linux-sources )"
RDEPEND=""

pkg_setup() {
	if use extensions; then
		einfo "WARNING: 3rd party extensions has been enabled."
		einfo "This means that iptables will use your currently installed"
		einfo "kernel in /usr/src/linux as headers for iptables."
		einfo ""
		einfo "You may have to patch your kernel to allow iptables to build."
		einfo "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ for patches"
		einfo "for your kernel."
	fi
}


src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PV}-files/grsecurity-1.2.8-iptables.patch.bz2
	epatch ${FILESDIR}/${PV}-files/install_ipv6_apps.patch.bz2
	epatch ${FILESDIR}/${PV}-files/install_all_dev_files.patch.bz2
	epatch ${FILESDIR}/${PV}-files/round-robin.patch
	epatch ${FILESDIR}/${PV}-files/CAN-2004-0986.patch ; # security bug 70240
	sed -i "s/PF_EXT_SLIB:=/PF_EXT_SLIB:=stealth /g" extensions/Makefile

	if use extensions; then
		epatch ${FILESDIR}/${PV}-files/iptables-1.2.9-imq1.diff.bz2
		epatch ${FILESDIR}/${PV}-files/iptables-layer7-0.9.0.patch.bz2

		chmod +x extensions/.IMQ-test*
		chmod +x extensions/.childlevel-test*
		chmod +x extensions/.layer7-test*

	fi
}

src_compile() {
	replace-flags -O0 -O2

	if [ -z `get-flag O` ]; then
		append-flags -O2
	fi

	# prevent it from causing ICMP errors.
	# http://bugs.gentoo.org/show_bug.cgi?id=23645
	filter-flags "-fstack-protector"

	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.

	use ipv6 || myconf="${myconf} DO_IPV6=0"
	use static && myconf="${myconf} NO_SHARED_LIBS=0"

	if use extensions; then
		# Only check_KV if /usr/src/linux exists
		if [ -L ${ROOT}/usr/src/linux -o -d ${ROOT}/usr/src/linux ]; then
			check_KV
		else
			ewarn "You don't have kernel sources available at /usr/src/linux."
			ewarn "Iptables will be built against linux-headers."
		fi

		make COPT_FLAGS="${CFLAGS}" ${myconf} \
			PREFIX= \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			|| die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
	else
		make COPT_FLAGS="${CFLAGS}" ${myconf} \
			PREFIX= \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr \
			|| die
	fi
}

src_install() {
	if use extensions; then
		make DESTDIR=${D} ${myconf} \
			PREFIX= \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			install || die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"

		make DESTDIR=${D} ${myconf} \
			PREFIX= \
			LIBDIR=/usr/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			install-devel || die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
	else
		make DESTDIR=${D} ${myconf} \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr \
			install || die

		make DESTDIR=${D} ${myconf} \
			LIBDIR=/usr/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr \
			install-devel || die
	fi

	dodoc COPYING
	dodir /var/lib/iptables ; keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}-1.2.9-r1.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/${PN}-1.2.9-r1.confd iptables

	if use ipv6; then
		dodir /var/lib/ip6tables ; keepdir /var/lib/ip6tables
		exeinto /etc/init.d
		newexe ${FILESDIR}/${PN/iptables/ip6tables}-1.2.9-r1.init ip6tables
		insinto /etc/conf.d
		newins ${FILESDIR}/${PN/iptables/ip6tables}-1.2.9-r1.confd ip6tables
	fi
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	use ipv6 >/dev/null && einfo "and /var/lib/ip6tables/rules-save"
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
