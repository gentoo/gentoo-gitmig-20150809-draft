# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.2.9.ebuild,v 1.4 2004/01/26 10:40:42 aliz Exp $

inherit eutils flag-o-matic

# prevent it from causing ICMP errors.
# http://bugs.gentoo.org/show_bug.cgi?id=23645
filter-flags "-fstack-protector"

IUSE="ipv6"

S=${WORKDIR}/${P}
DESCRIPTION="Linux kernel (2.4+) firewall, NAT and packet mangling tools"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"
HOMEPAGE="http://www.iptables.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~arm ~mips ~ia64 amd64"
LICENSE="GPL-2"

# iptables is dependent on kernel sources.  Strange but true.
DEPEND="virtual/os-headers"

src_unpack() {
	if [ -z $( get-flag O ) ]; then
		append-flags -O2
	fi

	replace-flags -O0 -O2

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-files

	# The folowing hack is needed because ${ARCH} is "sparc" and not "sparc64"
	# and epatch uses ??_${ARCH}_foo.${EPATCH_SUFFIX} when reading from directories
	[ "${PROFILE_ARCH}" = "sparc64" ] && epatch ${FILESDIR}/sparc64_limit_fix.patch.bz2

	chmod +x extensions/.IMQ-test*

	sed -i -e "s:-O2:${CFLAGS} -Iinclude:g" -e "s:/usr/local::g" -e "s:-Iinclude/::" Makefile
}

src_compile() {
	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.

	use ipv6 && myconf="${myconf} DO_IPV6=1" || myconf="${myconf} DO_IPV6=0"

	make \
		LIBDIR=/lib \
		BINDIR=/sbin \
		MANDIR=/usr/share/man \
		INCDIR=/usr/include \
		KERNEL_DIR=/usr/src/linux \
		|| die
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
	newexe ${FILESDIR}/iptables.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/iptables.confd iptables

	if [ `use ipv6` ]; then
		dodir /var/lib/ip6tables ; keepdir /var/lib/ip6tables
		exeinto /etc/init.d
		newexe ${FILESDIR}/ip6tables.init ip6tables
		insinto /etc/conf.d
		newins ${FILESDIR}/ip6tables.confd ip6tables
	fi
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	einfo "This location can be changed in /etc/conf.d/iptables"

	einfo "If you are using the iptables initsscript you should save your"
	einfo "rules using the new iptables version before rebooting."
}

