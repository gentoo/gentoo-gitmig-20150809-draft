# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-fs/samba/samba-2.0.10-r6.ebuild,v 1.3 2001/09/09 09:32:13 woodchip Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Samba"
SRC_URI="http://us1.samba.org/samba/ftp/${A}"
HOMEPAGE="http://www.samba.org"

DEPEND="virtual/glibc
	>=sys-libs/pam-0.72"
	#ssl support removed -- it doesn't work...


src_compile() {

  cd ${S}/source
  ./configure --prefix=/usr --sysconfdir=/etc/smb --localstatedir=/var/log \
	--libdir=/etc/smb --sbindir=/usr/sbin --with-automount --with-utmp \
	--without-sambabook --with-netatalk --with-smbmount --with-profile \
	--with-pam --with-privatedir=/etc/smb/private --with-lockdir=/var/run/smb \
	--with-swatdir=/usr/share/swat
  assert
  make || die
}


src_install() {

  cd ${S}/source
  dodir /usr
  dodir /etc/smb
  dodir /usr/share/swat
  dodir /usr/doc/${P}/html/book
  dodir /var/log
  dodir /var/run/smb

  make install prefix=${D}/usr BASEDIR=${D}/usr LIBDIR=${D}/etc/smb VARDIR=${D}/var/log \
	PRIVATEDIR=${D}/etc/smb/private SWATDIR=${D}/usr/share/swat \
	LOCKDIR=${D}/var/lock SBINDIR=${D}/usr/sbin || die

  # we specified PRIVATEDIR=/etc/smb/private
  rm -rf ${D}/usr/private
  diropts -m0700
  dodir /etc/smb/private

  # move smbmount from /usr/sbin to /sbin, and rename it to mount.smbfs
  # which allows it to work transparently with standard 'mount' command
  dodir /sbin
  mv ${D}/usr/bin/smbmount ${D}/sbin/mount.smbfs

  cd ${S}/source/script
  exeinto /usr/sbin
  doexe convert_smbpasswd mknissmbpasswd.sh mknissmbpwdtbl.sh mksmbpasswd.sh smbtar

  prepman
  into /usr
  cd ${S}
  cp -a examples ${D}/usr/doc/${PF}
  cp examples/smb.conf.default ${D}/etc/smb/smb.conf.example
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

  exeinto /etc/init.d
  newexe ${FILESDIR}/samba.rc6 samba
}


pkg_preinst() {

  if [ "$ROOT" = "/" ] && [ -e /etc/init.d/samba ] ; then
	if [ -e /dev/shm/.init.d/started/samba ] ; then
		/etc/init.d/samba stop
  	fi
  fi
  return # dont fail
}


pkg_postinst() {

  # we touch ${D}/etc/smb/smb.conf so that people installing samba just to mount smb shares
  # don't get annoying warnings all the time.
  if [ ! -e ${ROOT}etc/smb/smb.conf ] ; then
	touch ${ROOT}etc/smb/smb.conf
  fi

  echo " #"
  echo " If you had samba running earlier, you'll need to start it again. Also, please note"
  echo " that you must configure /etc/smb/smb.conf before samba (the server) will work properly."
  echo " Mounting smb shares and the smbclient program should work immediately.  To accomplish"
  echo " this there is an empty /etc/smb/smb.conf file installed."
  echo
  echo " To mount smb shares, type something like this. You will need kernel SMB support first:"
  echo " % mount -t smbfs -o username=drobbins,password=foo,ip=192.168.1.1 //mybox/drobbins /mnt/foo"
  echo " If you wish to allow normal users to mount smb shares, type the following as root:"
  echo " % chmod u+s /usr/bin/smbmnt"
  echo " #"
}
