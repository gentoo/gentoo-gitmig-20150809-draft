# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.9_p2-r1.ebuild,v 1.2 2001/06/27 03:52:56 achim Exp $

P=openssh-2.9p2
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.de.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/"${A}
HOMEPAGE="http://www.openssh.com/"

DEPEND="virtual/glibc sys-devel/perl sys-apps/groff
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	pam? ( >=sys-libs/pam-0.73 )
	>=dev-libs/openssl-0.9.6"

RDEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.73 )
	>=dev-libs/openssl-0.9.6"

src_compile() {
    local myconf
    if [ "`use tcpd`" ]
    then
		myconf="--with-tcp-wrappers"
    else
		myconf="--without-tcp-wrappers"
	fi
    if [ "`use pam`" ]
    then
	myconf="${myconf} --with-pam"
    else
	myconf="${myconf} --without-pam"
    fi

    try ./configure --prefix=/usr --sysconfdir=/etc/ssh \
	--libexecdir=/usr/lib/misc --mandir=/usr/share/man \
	--with-ipv4-default --disable-suid-ssh --host=${CHOST} ${myconf}                         
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

