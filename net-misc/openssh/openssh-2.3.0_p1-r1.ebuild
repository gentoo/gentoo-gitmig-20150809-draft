# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.3.0_p1-r1.ebuild,v 1.2 2000/12/10 05:35:55 drobbins Exp $

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
    dodoc ChangeLog COPYING.* CREDITS OVERVIEW README* TODO UPGRADING
    insinto /etc/pam.d
    donewins ${FILESDIR}/sshd.pam sshd
    exeinto /etc/rc.d/init.d
    doexe ${FILESDIR}/sshd
	exeinto /etc/svc.d/services/sshd
	touch ${D}/etc/svc.d/services/sshd/down
	newexe ${FILESDIR}/sshd-run run
	dodir /etc/svc.d/control
	dosym ../services/sshd /etc/svc.d/control/sshd
}

pkg_preinst() {
	[ "$ROOT" = "/" ] && [ -e /etc/rc.d/init.d/sshd ] && /etc/rc.d/init.d/sshd stop
	${ROOT}/etc/rc.d/init.d/rc-update del sshd
}

pkg_postinst() {
	# Make ssh start at boot
	. ${ROOT}/etc/rc.d/config/functions
	einfo ">>> Generating symlinks"
	${ROOT}/usr/sbin/rc-update add sshd
	if [ ! -e ${ROOT}/etc/ssh/ssh_host_key ] ; then
		einfo "Generating system RSA key..."
		${ROOT}/usr/bin/ssh-keygen -b 1024 -f ${ROOT}/etc/ssh/ssh_host_key -N ''
	else
		einfo "System RSA key already exists, skipping..."
	fi

	if [ ! -e ${ROOT}/etc/ssh/ssh_host_dsa_key ] ; then
		einfo "Generating system DSA key..."
		${ROOT}/usr/bin/ssh-keygen -d -f ${ROOT}/etc/ssh/ssh_host_dsa_key -N ''
	else
		einfo "System DSA key already exists, skipping..."
	fi
	[ "$ROOT" = "/" ] && /etc/rc.d/init.d/sshd start
}

