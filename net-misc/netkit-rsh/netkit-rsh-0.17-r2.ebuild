# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-rsh/netkit-rsh-0.17-r2.ebuild,v 1.6 2002/08/14 12:08:08 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Netkit - rshd"
SRC_URI="http://ftp.debian.org/debian/pool/main/n/${PN}/${PN}_${PV}.orig.tar.gz"
KEYWORDS="x86 sparc sparc64"
LICENSE="bsd"
SLOT="0"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	>=sys-libs/pam-0.72"

src_unpack () {
	unpack ${A}
	cd ${S}
	patch -p0 < ${O}/files/rlogind-auth.diff || die
}

src_compile() {
	./configure || die
	cp MCONFIG MCONFIG.orig
	sed -e "s/-pipe -O2/${CFLAGS}/" \
		-e "s:-Wpointer-arith::" \
		MCONFIG.orig > MCONFIG

	make || die
}

src_install() {							   
	into /usr
	dobin  rcp/rcp
	fperms 4755 /usr/bin/rcp
	doman  rcp/rcp.1
	dobin  rexec/rexec
	doman  rexec/rexec.1
	dosbin rexecd/rexecd
	dosym  rexecd /usr/sbin/in.rexecd
	doman  rexecd/rexecd.8
	dosym  rexecd.8.gz /usr/share/man/man8/in.rexecd.8.gz
	dobin  rlogin/rlogin
	fperms 4755 /usr/bin/rlogin
	doman  rlogin/rlogin.1
	dosbin rlogind/rlogind
	dosym  rlogind /usr/sbin/in.rlogind
	doman  rlogind/rlogind.8
	dosym  rlogind.8.gz /usr/share/man/man8/in.rlogind.8.gz
	dobin  rsh/rsh
	fperms 4755 /usr/bin/rsh
	doman  rsh/rsh.1
	dosbin rshd/rshd
	dosym  rshd /usr/sbin/in.rshd
	doman  rshd/rshd.8
	dosym  rshd.8.gz /usr/share/man/man8/in.rshd.8.gz
	dodoc  README ChangeLog BUGS
	newdoc rexec/README README.rexec
}
