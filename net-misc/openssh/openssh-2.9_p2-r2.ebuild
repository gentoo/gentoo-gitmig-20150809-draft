# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Team: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.9_p2-r2.ebuild,v 1.3 2001/09/03 21:47:39 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.openbsd.org/pub/unix/OpenBSD/OpenSSH/portable/openssh-2.9p2.tar.gz"
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

    ./configure --prefix=/usr --sysconfdir=/etc/ssh \
	--libexecdir=/usr/lib/misc --mandir=/usr/share/man \
	--with-ipv4-default --disable-suid-ssh --host=${CHOST} ${myconf} || die
    make || die
}

src_install() {                               
    make install-files DESTDIR=${D} || die
    dodoc ChangeLog CREDITS OVERVIEW README* TODO
    insinto /etc/pam.d
    donewins ${FILESDIR}/sshd.pam sshd
    exeinto /etc/init.d
    newexe ${FILESDIR}/openssh sshd
}

pkg_postinst() {
	# Make ssh start at boot
	rc-update add sshd default
}

