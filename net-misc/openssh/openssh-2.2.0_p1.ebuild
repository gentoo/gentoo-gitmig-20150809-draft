# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/openssh/openssh-2.2.0_p1.ebuild,v 1.1 2000/09/10 17:43:11 achim Exp $

P=openssh-2.2.0p1
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Port of OpenBSD's free SSH release"
SRC_URI="ftp://ftp.openbsd.org/pub/OpenBSD/OpenSSH/portable/"${A}
HOMEPAGE="http://www.openssh.com/"

src_compile() {
    ./configure --prefix=/usr --sysconfdir=/etc/ssh \
	--libexecdir=/usr/libexec --mandir=/usr/man \
	--enable-gnome-askpass \
	--with-tcp-wrappers --with-ipv4-default --host=${CHOST}                          
    make
}

src_unpack() {
    unpack ${A}
    cd ${S}
#    patch -p0 < contrib/chroot.diff
}

src_install() {                               
    make manpages install-files DESTDIR=${D} 
    prepman
    dodoc ChangeLog COPYING.* CREDITS OVERVIEW README* TODO UPGRADING
    dodir /etc/rc.d/init.d/
    cp ${O}/files/sshd ${D}/etc/rc.d/init.d/sshd
}

pkg_config() {

  # Make ssh start at boot
  echo "Generating symlinks"
  ${ROOT}/usr/sbin/rc-update add sshd

}



