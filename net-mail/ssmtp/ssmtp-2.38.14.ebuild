# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author AJ Lewis <lewis@sistina.com>
# $Header: /var/cvsroot/gentoo-x86/net-mail/ssmtp/ssmtp-2.38.14.ebuild,v 1.2 2001/08/30 17:31:35 pm Exp $


A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Extremely simple MTA to get mail off the system to a Mailhub"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/system/mail/mta/${A}"

DEPEND="virtual/glibc
        >=net-mail/mailbase-0.00"

RDEPEND="!virtual/mta"

PROVIDE="virtual/mta"

src_compile() {                           
   try make clean
   try make ${MAKEOPTS}
}

src_install() {                               
    dodir /usr/bin /usr/sbin /usr/lib
    dosbin ssmtp
    chmod 755 ${D}/usr/sbin/ssmtp
    dosym /usr/sbin/ssmtp /usr/bin/mailq
    dosym /usr/sbin/ssmtp /usr/bin/newaliases
    dosym /usr/sbin/ssmtp /usr/bin/mail
    dosym /usr/sbin/ssmtp /usr/sbin/sendmail
    dosym /usr/sbin/ssmtp /usr/lib/sendmail
    doman ssmtp.8
    dosym /usr/share/man/man8/ssmtp.8 /usr/share/man/man8/sendmail.8
    dodoc CHANGELOG INSTALL MANIFEST README
    newdoc ssmtp.lsm DESC
    insinto /etc/ssmtp
      doins ssmtp.conf revaliases
}

pkg_config() {
  echo "Please edit /etc/ssmtp/ssmtp.conf"
}


