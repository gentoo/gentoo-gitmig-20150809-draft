# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/squid/squid-2.3.4s-r3.ebuild,v 1.2 2001/05/18 17:01:25 achim Exp $

P=squid-2.3.STABLE4

A0=squid-2.3.stable4-ftp_icon_not_found.patch
A1=squid-2.3.stable4-internal_dns_rcode_table_formatting.patch
A2=squid-2.3.stable4-ipfw_configure.patch
A3=squid-2.3.stable4-invalid_ip_acl_entry.patch 
A4=squid-2.3.stable4-accel_only_access.patch 
A5=squid-2.3.stable4-html_quoting.patch 
A6=squid-2.3.stable4-carp-assertion.patch

S=${WORKDIR}/${P}
DESCRIPTION="SQUID - Web Proxy Server"
SRC_URI0="http://www.squid-cache.org/Versions/v2/2.3"
SRC_URI="$SRC_URI0/${P}-src.tar.gz
	 $SRC_URI0/bugs/$A0 $SRC_URI0/bugs/$A1 $SRC_URI0/bugs/$A2
	 $SRC_URI0/bugs/$A3 $SRC_URI0/bugs/$A4 $SRC_URI0/bugs/$A5 
	 $SRC_URI0/bugs/$A6"

HOMEPAGE="http://www.squid-cache.org/"

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	ldap? ( >=net-nds/openldap-1.2.11 )"

src_unpack() {
  unpack ${P}-src.tar.gz
  cd ${S}
  patch -p0 < ${DISTDIR}/${A0}
  patch -p0 < ${DISTDIR}/${A1} 
  patch -p0 < ${DISTDIR}/${A2} 
  patch -p0 < ${DISTDIR}/${A3} 
  patch -p0 < ${DISTDIR}/${A4} 
  patch -p0 < ${DISTDIR}/${A5} 

}

src_compile() {                           
 cd ${S}
 LDFLAGS="$LDFLAGS -lresolv" try ./configure --host=${CHOST} \
	--prefix=/usr --sysconfdir=/etc/squid \
	--localstatedir=/var/state/squid \
	--enable-useragent-log \
	--enable-async-io --enable-icmp
 try make
 cd ${S}/auth_modules/PAM
 try make
 cd ../SMB
 try make
 if [ "`use ldap`" ] ; then
   cd ../LDAP
   try make
 fi
 cd ../NCSA
 try make

}

src_install() {                               
  cd ${S}
  rm -rf ${D}
  dodir /usr/bin
  dodir /etc/squid
  dodir /var/squid
  chown squid.daemon ${D}/var/squid
  try make install prefix=${D}/usr sysconfdir=${D}/etc/squid \
	localstatedir=${D}/var/state/squid 
  into /usr
  cd auth_modules
  if [ "`use ldap`" ] ; then
    dobin LDAP/squid_ldap_auth 
  fi
  dobin PAM/pam_auth SMB/smb_auth NCSA/ncsa_auth
  cd ../doc
  doman tree.3
  dodoc *.txt
  cd ..
  dodoc README QUICKSTART CONTRIBUTORS COPYRIGHT COPYING CREDITS
  dodoc ChangeLog TODO
  cp ${FILESDIR}/squid.conf ${D}/etc/squid
  dodir /etc/rc.d/init.d
  cp ${FILESDIR}/squid ${D}/etc/rc.d/init.d
#  rm -r ${D}/var/squid
  dodir /var/log/squid
  dodir /var/cache/squid
  fowners squid.daemon /var/log/squid
  fowners squid.daemon /var/cache/squid
  fperms 755 /var/log/squid
  fperms 755 /var/cache/squid
}

pkg_config() {

    . ${ROOT}/etc/rc.d/config/functions 

  einfo "Generating symlinks..."
  ${ROOT}/usr/sbin/rc-update add squid

}
