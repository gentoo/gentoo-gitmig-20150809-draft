# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.2.9-r2.ebuild,v 1.1 2004/06/23 18:43:16 aliz Exp $

inherit eutils flag-o-matic

DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
HOMEPAGE="http://www.iptables.org/"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"
#KEYWORDS="x86 ~ppc sparc ~mips alpha arm hppa amd64 ia64"
IUSE="ipv6 static extensions"

# iptables is dependent on kernel sources.  Strange but true.
DEPEND="virtual/linux-sources"

pkg_preinst() {
	if [ "`use extensions`" ]; then
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
	replace-flags -O0 -O2

	if [ -z `get-flag O` ]; then
		append-flags -O2
	fi

	unpack ${A} ; cd ${S}

	if [ "`use extensions`" ]; then
		epatch ${FILESDIR}/extensions/${P}-grsecurity.patch.bz2
		epatch ${FILESDIR}/extensions/${P}-imq.patch.bz2
		epatch ${FILESDIR}/extensions/${P}-l7.patch.bz2

		chmod +x extensions/.IMQ-test*
		chmod +x extensions/.childlevel-test*
		chmod +x extensions/.layer7-test*
	fi

	# The folowing hack is needed because ${ARCH} is "sparc" and not "sparc64"
	# and epatch uses ??_${ARCH}_foo.${EPATCH_SUFFIX} when reading from directories
	[ "${PROFILE_ARCH}" = "sparc64" ] && epatch ${FILESDIR}/sparc64_limit_fix.patch.bz2
	usr hppa && epatch ${FILESDIR}/${P}-hppa.patch.bz2

	sed -i -e "s:-O2:${CFLAGS} -Iinclude:g" -e "s:/usr/local::g" -e "s:-Iinclude/::" Makefile
}

src_compile() {
	# Only check_KV if /usr/src/linux exists
	if [ -L ${ROOT}/usr/src/linux -o -d ${ROOT}/usr/src/linux ]; then
		check_KV
	fi

	# prevent it from causing ICMP errors.
	# http://bugs.gentoo.org/show_bug.cgi?id=23645
	filter-flags "-fstack-protector"

	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.

	use ipv6 || myconf="${myconf} DO_IPV6=0"
	use static && myconf="${myconf} NO_SHARED_LIBS=0"

	if [ "`use extensions`" ]; then
		make ${myconf} \
			LIBDIR=/lib \
			BINDIR=/sbin \
			MANDIR=/usr/share/man \
			INCDIR=/usr/include \
			KERNEL_DIR=/usr/src/linux \
			|| (
				eerror "Please check http://cvs.iptables.org/patch-o-matic-ng/updates/ if your kernel needs to be patched for iptables"
				die
			)
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
	make DESTDIR=${D} MANDIR=/usr/share/man ${myconf} install
	make DESTDIR=${D} ${myconf} \
		LIBDIR=/usr/lib \
		MANDIR=/usr/share/man \
		INCDIR=/usr/include \
		install-devel

	dodoc COPYING
	dodir /var/lib/iptables ; keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/${PF}.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/${PF}.confd iptables

	if use ipv6; then
		dodir /var/lib/ip6tables ; keepdir /var/lib/ip6tables
		exeinto /etc/init.d
		newexe ${FILESDIR}/${PF/iptables/ip6tables}.init ip6tables
		insinto /etc/conf.d
		newins ${FILESDIR}/${PF/iptables/ip6tables}.confd ip6tables
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
	einfo "If you are uprading to a >=2.4.21 kernel you may need to rebuild"
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
