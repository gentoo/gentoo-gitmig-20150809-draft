# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <lamer@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/net-ftp/oftpd/oftpd-0.3.6.ebuild,v 1.1 2001/07/05 03:48:03 lamer Exp $

#P=
#A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Secure, small anonymous only ftpd"
SRC_URI="http://www.time-travellers.org/oftpd/${P}.tar.gz"
HOMEPAGE="http://www.time-travellers.org/oftpd/"

DEPEND=""

src_compile() {


# Broken upstream source. Won't compile with this enabled.
#local myconf
# if [ "`use ipv6`" ]; then
#	myconf="--enable-ipv6"
#fi

    try ./configure --prefix=/usr --bindir=/usr/sbin \
	${myconf} --mandir=/usr/share/man --host=${CHOST}
    try make

}

src_install () {

    try make DESTDIR=${D} install
	 dodoc AUTHORS BUGS COPYING INSTALL FAQ NEWS README TODO
	 exeinto /etc/rc.d/init.d
	 doexe ${FILESDIR}/oftpd

# Am disabling this untill I can figure out how to make the daemon write a
# pid file
#    doexe ${FILESDIR}/svc-oftpd
#    exeinto /var/lib/supervise/services/oftpd
#	 doexe ${FILESDIR}/oftpd-run
	 dodir /home/ftp
}

pkg_postinst() {
	einfo "Run \"rc-update add svc-oftpd\" to make the daemon start at boot"
	einfo "Add FTPUSER=\"ftp\" and FTPROOT=\"/home/ftp\" to
/etc/rc.d/config/basic"
}

