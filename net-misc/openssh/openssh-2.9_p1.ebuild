# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.9_p1.ebuild,v 1.1 2001/05/06 16:19:49 achim Exp $

P=openssh-2.9p1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.de.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/"${A}
HOMEPAGE="http://www.openssh.com/"

DEPEND="virtual/glibc
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	pam? ( >=sys-libs/pam-0.73 )
	>=dev-libs/openssl-0.9.6"
	
src_compile() {
    local myconf
    if [ "`use tcpd`" ]
    then
	myconf="--with-tcp-wrappers"
    fi
    if [ "`use pam`" ]
    then
	myconf="${myconf} --with-pam"
    else
	myconf="${myconf} --without-pam"
    fi

    try ./configure --prefix=/usr --sysconfdir=/etc/ssh \
	--libexecdir=/usr/lib/misc --mandir=/usr/share/man \
	--with-ipv4-default --host=${CHOST} ${myconf}                         
    try make
}

src_install() {                               

    try make install-files DESTDIR=${D} 
    dodoc ChangeLog CREDITS OVERVIEW README* TODO
    insinto /etc/pam.d
    donewins ${FILESDIR}/sshd.pam sshd
    exeinto /etc/rc.d/init.d
    newexe ${FILESDIR}/openssh sshd
    newexe ${FILESDIR}/svc-openssh svc-sshd
    exeinto /var/lib/supervise/services/sshd
    newexe ${FILESDIR}/sshd-run run
}


pkg_postinst() {
	# Make ssh start at boot
	. ${ROOT}/etc/rc.d/config/functions
	einfo ">>> Generating symlinks"
	${ROOT}/usr/sbin/rc-update add svc-sshd
}

