# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r6.ebuild,v 1.20 2003/06/21 21:19:40 drobbins Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Standard linux net thingees -- inetd, ping"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa"

DEPEND="virtual/glibc"

PROVIDE="virtual/inetd"

src_unpack() {
	unpack ${A}
	cd ${S}

	use alpha && epatch ${FILESDIR}/001_alpha_${P}-ping-fix.patch.bz2
}

src_compile() {
	./configure || die

	cp MCONFIG MCONFIG.orig
	#sed -e "s/-O2/${CFLAGS}  -Wstrict-prototypes -fomit-frame-pointer/"
	sed -e "s:^CFLAGS=.*:CFLAGS=${CFLAGS} -Wall -Wbad-function-cast -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline:" \
		MCONFIG.orig > MCONFIG

	emake || die "compile problem"
}

src_install() {
	exeopts -m 4755
	exeinto /bin
	doexe ping/ping

	if [ -z "`use build`" ]
	then
		cd ${S}/etc.sample
		sed -e 's:in\.telnetd$:in.telnetd -L /usr/sbin/telnetlogin:' \
			< inetd.conf > inetd.conf.new
		mv inetd.conf.new inetd.conf
		cd ${S}

		exeopts -m 755
		exeinto /usr/bin
		dosbin inetd/inetd
		doman inetd/inetd.8 inetd/daemon.3 ping/ping.8
		
		dodoc BUGS ChangeLog README
		docinto samples ; dodoc etc.sample/*
		exeinto /etc/init.d ; newexe ${FILESDIR}/inetd.rc6 inetd
	fi
}
