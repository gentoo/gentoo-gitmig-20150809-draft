# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/squid/squid-2.3.STABLE4-r1.ebuild,v 1.2 2000/08/16 04:38:21 drobbins Exp $

P=squid-2.3.STABLE4
A=${P}-src.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="SQUID - Web Proxy Server"
SRC_URI="http://www.squid-cache.org/Versions/v2/2.3/"${A}
HOMEPAGE="http://www.squid-cache.org/"

src_compile() {                           
 cd ${S}
 LDFLAGS="$LDFLAGS -lresolv" ./configure --host=${CHOST} \
	--prefix=/usr --sysconfdir=/etc/squid \
	--localstatedir=/var/squid
	--enable-ipf-transparent --enable-useragent-log \
	--enable-async-io --enable-icmp
 make
 cd ${S}/auth_modules/LDAP
 make
 cd ../PAM
 make
 cd ../SMB
 make
 cd ../LDAP
 make
 cd ../NCSA
 make

}

src_install() {                               
  cd ${S}
  rm -rf ${D}
  dodir /usr/bin
  dodir /etc/squid
  dodir /var/squid
  chown squid.daemon ${D}/var/squid
  make install prefix=${D}/usr sysconfdir=${D}/etc/squid \
	localstatedir=${D}/var/squid 
  into /usr
  cd auth_modules
  dobin LDAP/squid_ldap_auth PAM/pam_auth SMB/smb_auth NCSA/ncsa_auth
  cd ../doc
  doman tree.3
  dodoc *.txt
  cd ..
  dodoc README QUICKSTART CONTRIBUTORS COPYRIGHT COPYING CREDITS
  dodoc ChangeLog TODO
  cp ${O}/files/squid.conf ${D}/etc/squid
  dodir /etc/rc.d/init.d
  cp ${O}/files/squid ${D}/etc/rc.d/init.d
  rm -r ${D}/var/squid
  dodir /var/log/squid
  dodir /var/cache/squid
  fowners squid.daemon /var/log/squid
  fowners squid.daemon /var/cache/squid
  fperms 644 /var/log/squid
  fperms 644 /var/cache/squid
}

pkg_config() {

    . ${ROOT}/etc/rc.d/config/functions 

  einfo "Generating symlinks..."
  ${ROOT}/usr/sbin/rc-update add squid

}
