# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.0.7-r1.ebuild,v 1.8 2000/12/28 15:31:10 drobbins Exp $

P=samba-2.0.7
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Samba"
SRC_URI="ftp://sunsite.org.uk/packages/samba/${A}"
HOMEPAGE="http://www.samba.org"

DEPEND=">=sys-apps/bash-2.04
	>=sys-apps/gawk-3.0.6
	>=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72"

#ssl support removed -- it doesn't work...

src_compile() { 
  cd ${S}/source
  CFLAGS="$CFLAGS -I/usr/include/openssl" try ./configure --prefix=/usr \
	--sysconfdir=/etc/smb --localstatedir=/var/log --libdir=/etc/smb --sbindir=/usr/sbin \
	--with-automount \
	--with-utmp --without-sambabook --with-netatalk \
	--with-smbmount --with-pam --with-syslog \
	--with-privatedir=/etc/smb/private --with-lockdir=/var/lock --with-swatdir=/usr/share/swat
  try make
}

src_install() { 
	cd ${S}/source
	dodir /usr
	dodir /etc/smb
	dodir /usr/share/swat
	dodir /usr/doc/${P}/html/book
	dodir /var/log
	dodir /var/lock
	try make install prefix=${D}/usr BASEDIR=${D}/usr LIBDIR=${D}/etc/smb VARDIR=${D}/var/log \
		PRIVATEDIR=${D}/etc/smb/private SWATDIR=${D}/usr/share/swat \
		LOCKDIR=${D}/var/lock SBINDIR=${D}/usr/sbin
	prepman

	into /usr
	cd ${S}
	dodoc COPYING Manifest README README-smbmount Roadmap WHATSNEW.txt
	cd ${S}/docs
	dodoc announce history NT4-Locking.reg NT4-Locking.txt NT4_PlainPassword.reg
	dodoc samba.lsm THANKS Win*
	docinto html
	dodoc htmldocs/*.html
	docinto html/book
	dodoc htmldocs/using_samba/*.html
	docinto html/book/gifs
	dodoc htmldocs/using_samba/gifs/*
	docinto html/book/figs
	dodoc htmldocs/using_samba/figs/*
	docinto faq
	dodoc faq/*.txt
	docinto html/faq
	dodoc faq/*.html
	docinto textdocs
	dodoc textdocs/*
	cd ${S}
	cp -a examples ${D}/usr/doc/${PF}
	cp examples/smb.conf.default ${D}/etc/smb/smb.conf.example
	dodir /etc/rc.d/init.d
	cp ${O}/files/samba ${D}/etc/rc.d/init.d
	diropts -m0700
	dodir /etc/smb/private
}

pkg_config() {

    source ${ROOT}/etc/rc.d/config/functions

    echo "Generating symlinks..."

    ${ROOT}/usr/sbin/rc-update add samba

}






