# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.2.9-r4.ebuild,v 1.8 2005/08/25 04:35:11 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc sparc x86"
IUSE="ipv6 static extensions"

DEPEND="virtual/os-headers
	extensions? ( virtual/linux-sources )"
RDEPEND=""

pkg_setup() {
	if use extensions; then
		einfo "WARNING: 3rd party extensions has been enabled."
		einfo "This means that iptables will use your currently installed"
		einfo "kernel in /usr/src/linux as headers for iptables."
		einfo
		einfo "You may have to patch your kernel to allow iptables to build."
		einfo "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ for patches"
		einfo "for your kernel."
	fi
}


src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${PV}-files/04_all_install_ipv6_apps.patch.bz2
	epatch ${FILESDIR}/${PV}-files/05_all_install_all_dev_files.patch.bz2

	# The folowing hack is needed because ${ARCH} is "sparc" and not "sparc64"
	# and epatch uses ??_${ARCH}_foo.${EPATCH_SUFFIX} when reading from directories
	[ "${PROFILE_ARCH}" = "sparc64" ] && epatch ${FILESDIR}/${PV}-files/sparc64_limit_fix.patch.bz2
	use hppa && epatch ${FILESDIR}/${PV}-files/03_hppa_gentoo.patch.bz2

	if use extensions; then
		epatch ${FILESDIR}/${PV}-files/01_all_grsecurity.patch.bz2
		epatch ${FILESDIR}/${PV}-files/02_all_imq.patch.bz2
		epatch ${FILESDIR}/${PV}-files/06_all_l7.patch.bz2

		chmod +x extensions/.IMQ-test*
		chmod +x extensions/.childlevel-test*
		chmod +x extensions/.layer7-test*
	fi

	if [ -z `get-flag O` ]; then
		append-flags -O2
	fi

	# prevent it from causing ICMP errors.
	# http://bugs.gentoo.org/show_bug.cgi?id=23645
	filter-flags "-fstack-protector"

	sed -i -e "s:-O2:${CFLAGS} -Iinclude:g" -e "s:/usr/local::g" -e "s:-Iinclude/::" Makefile
}

src_compile() {
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

		make ${myconf} \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			|| die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
	else
		make ${myconf} \
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
			LIBDIR=/lib \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			install || die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"

		make DESTDIR=${D} ${myconf} \
			LIBDIR=/usr/lib \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			install-devel || die "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
	else
		make DESTDIR=${D} ${myconf} \
			LIBDIR=/lib \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr \
			install || die

		make DESTDIR=${D} ${myconf} \
			LIBDIR=/usr/lib \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr \
			install-devel || die
	fi

	dodoc COPYING
	dodir /var/lib/iptables ; keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PN}-${PV}-r1.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/${PN}-${PV}-r1.confd iptables

	if use ipv6; then
		dodir /var/lib/ip6tables ; keepdir /var/lib/ip6tables
		exeinto /etc/init.d
		newexe ${FILESDIR}/${PN/iptables/ip6tables}-${PV}-r1.init ip6tables
		insinto /etc/conf.d
		newins ${FILESDIR}/${PN/iptables/ip6tables}-${PV}-r1.confd ip6tables
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
	ewarn "!!! ipforwarding is now not a part of the iptables initscripts."
	einfo
	einfo "To enable ipforwarding at bootup:"
	einfo "/etc/sysctl.conf and set net.ipv4.ip_forward = 1"
	if use ipv6 ; then
		einfo "and/or"
		einfo "  net.ipv6.ip_forward = 1"
		einfo "for ipv6."
	fi
}
