# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.2.5-r1.ebuild,v 1.3 2002/04/14 20:42:06 verwilst Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 firewall, NAT and packet mangling tools"
SRC_URI="http://netfilter.samba.org/files/${P}.tar.bz2"
SLOT="0"
# iptables is dependent on kernel sources.  Strange but true.
DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local::g" Makefile.orig > Makefile
}

src_compile() {
	#I had a problem with emake - DR
	make KERNEL_DIR=/usr/src/linux || die
}

src_install() {
	dodir /usr/{lib,share/man/man8,sbin}
	# iptables and libraries are now installed to /sbin and /lib.  Why?  So systems
	# with remote network-mounted /usr filesystems can get their network interfaces
	# up and running correctly without /usr.
	make LIBDIR=${D}/lib \
		BINDIR=${D}/sbin \
		MANDIR=${D}/usr/share/man \
		INCDIR=${D}/usr/include \
		install || die
	dodoc COPYING KNOWN_BUGS
}
