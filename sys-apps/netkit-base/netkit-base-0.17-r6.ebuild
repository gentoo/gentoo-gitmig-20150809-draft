# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r6.ebuild,v 1.8 2002/09/21 03:32:08 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Standard linux net thingees -- inetd, ping"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
KEYWORDS="x86 ppc sparc sparc64 alpha"
SLOT="0"
LICENSE="BSD"
DEPEND="virtual/glibc"


src_unpack() {

    unpack ${A}

    if [ ${ARCH} == "alpha" ]; then
		cd ${S}
        patch -p1 < ${FILESDIR}/netkit-base-0.17-alpha-ping-fix.patch
    fi

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
