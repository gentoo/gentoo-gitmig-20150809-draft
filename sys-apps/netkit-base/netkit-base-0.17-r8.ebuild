# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r8.ebuild,v 1.3 2003/06/30 08:29:54 avenj Exp $

inherit eutils

DESCRIPTION="Old-style inetd"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"

# Only keyword for your arch if you have iputils in your default profile!
KEYWORDS="x86 amd64 alpha ppc"
SLOT="0"
LICENSE="BSD"

DEPEND="virtual/glibc"

PROVIDE="virtual/inetd"

src_unpack() {
	unpack ${A}
	cd ${S}
	
	# Note that epatch will intelligently patch architecture specific
	# patches as well
	epatch ${FILESDIR}
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

	# avenj@gentoo.org 19 June 03:
	# Uncomment for the (obsolete) version of ping.
	# Most people should merge iputils instead.
#	exeinto /bin
#	doexe ping/ping

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
		doman inetd/inetd.8 inetd/daemon.3
#		doman inetd/inetd.8 inetd/daemon.3 ping/ping.8
		
		dodoc BUGS ChangeLog README
		docinto samples ; dodoc etc.sample/*
		exeinto /etc/init.d ; newexe ${FILESDIR}/inetd.rc6 inetd
	fi
}
