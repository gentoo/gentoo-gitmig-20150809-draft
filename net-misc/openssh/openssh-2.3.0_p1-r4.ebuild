# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.3.0_p1-r4.ebuild,v 1.2 2001/01/18 18:22:11 achim Exp $

P=openssh-2.3.0p1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/"${A}
HOMEPAGE="http://www.openssh.com/"

DEPEND=">=sys-apps/bash-2.04
	>=sys-apps/tcp-wrappers-7.6
	>=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=dev-libs/openssl-0.9.6"
	
src_compile() {
    try ./configure --prefix=/usr --sysconfdir=/etc/ssh \
	--libexecdir=/usr/libexec --mandir=/usr/man \
	--enable-gnome-askpass \
	--with-tcp-wrappers --with-ipv4-default --host=${CHOST}                          
    try make
}

src_unpack() {
    unpack ${A}
    cd ${S}
#    patch -p0 < contrib/chroot.diff
}

src_install() {                               
    try make manpages install-files DESTDIR=${D} 
    dodoc ChangeLog COPYING.* CREDITS OVERVIEW README* TODO
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

