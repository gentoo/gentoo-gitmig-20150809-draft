# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/iptables/iptables-1.2.7a-r4.ebuild,v 1.3 2003/04/19 06:59:10 prez Exp $

inherit eutils

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 firewall, NAT and packet mangling tools"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"
HOMEPAGE="http://www.iptables.org/"

SLOT="0"
KEYWORDS="x86 ~ppc ~alpha ~sparc ~hppa ~arm ~mips"
LICENSE="GPL-2"

# iptables is dependent on kernel sources.  Strange but true.
DEPEND="virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-files
	# The folowing hack is needed because ${ARCH} is "sparc" and not "sparc64"
	# and epatch uses ??_${ARCH}_foo.${EPATCH_SUFFIX} when reading from directories
	[ "${PROFILE_ARCH}" = "sparc64" ] && epatch ${FILESDIR}/sparc64_limit_fix.patch.bz2
	[ "${ARCH}" = "hppa" ] && epatch ${FILESDIR}/iptables-1.2.7a-hppa.diff

	chmod +x extensions/.IMQ-test*

	cp Makefile Makefile.new
	sed -e "s:-O2:${CFLAGS}:g" -e "s:/usr/local::g" Makefile.new > Makefile
}

src_compile() {
	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.

	make \
		LIBDIR=/lib \
		BINDIR=/sbin \
		MANDIR=/usr/share/man \
		INCDIR=/usr/include \
		KERNEL_DIR=/usr/src/linux \
		|| die
}

src_install() {
#	dodir /usr/{lib,share/man/man8,sbin}

	make DESTDIR=${D} MANDIR=/usr/share/man install
	make DESTDIR=${D} \
		LIBDIR=/usr/lib \
		MANDIR=/usr/share/man \
		INCDIR=/usr/include \
		install-devel

	dodoc COPYING KNOWN_BUGS
	dodir /var/lib/iptables ; keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/iptables.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/iptables.confd iptables
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	einfo "This location can be changed in /etc/conf.d/iptables"
}
