# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.20-r1.ebuild,v 1.2 2001/09/06 08:00:57 woodchip Exp $

AV="1.3.20"
MSV="2.8.4"

A="apache_${AV}.tar.gz mod_ssl-${MSV}-${AV}.tar.gz"
S=${WORKDIR}/apache_${AV}
DESCRIPTION="The Apache Web Server v1.3.19 with mod_ssl"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${AV}.tar.gz
	 ftp://ftp.modssl.org/source/mod_ssl-${MSV}-${AV}.tar.gz"
HOMEPAGE="http://www.apache.org http://www.modssl.org"

DEPEND="virtual/glibc
	>=sys-libs/db-3.2.3h-r3
	=sys-libs/db-1.85-r1
	ssl? ( >=dev-libs/openssl-0.9.6b )"


src_compile() {                           
   export SSL_BASE=SYSTEM
	export CFLAGS="${CFLAGS} -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
if [ "`use ssl`" ]; then
   cd ${S}/../mod_ssl-${MSV}-${AV}
    try ./configure --with-apache=${S} --with-ssl=SYSTEM
   cd ${S}
fi
local myconf
if [ "`use ssl`" ]; then
	myconf="--enable-module=ssl"
fi
   export RULE_EXPAT=NO
   try ./configure --prefix=/usr/local/httpd --bindir=/usr/bin \
	--sbindir=/usr/sbin --datadir=/usr/local/httpd \
	--sysconfdir=/etc/httpd --libexecdir=/usr/lib/apache \
	--mandir=/usr/share/man --logfiledir=/var/log/apache --localstatedir=/var/lock \
	--proxycachedir=/var/cache/httpd --includedir=/usr/include/apache \
	--enable-module=all \
	--enable-shared=max --suexec-caller=wwwrun \
	--suexec-userdir=public_html --suexec-uidmin=96 \
	--suexec-gidmin=96 --suexec-safepath="/bin:/usr/bin" \
	--disable-rule=EXPAT --with-perl=/usr/bin/perl ${myconf}
#	--disable-module=auth_dbm"
	
    try make
if [ "`use ssl`" ]; then
    try make certificate TYPE=dummy
fi
}

src_install() { 
    try make install-quiet root=${D}
    dosed "s:/usr/local/bin/perl5:/usr/bin/perl:" /usr/local/httpd/htdocs/manual/search/manual-index.cgi
    cd ${D}/usr/sbin
    cp apachectl apachectl.orig
    sed -e "s:^PIDFILE.*:PIDFILE=/var/run/httpd.pid:" \
	apachectl.orig > apachectl
    rm apachectl.orig
    cd ${S}
    dodoc ABOUT_APACHE Announcement INSTALL* KEYS LICENSE* README* WARNING*
if [ "`use ssl`" ];then
    docinto mod_ssl
    cd ../mod_ssl-${MSV}-${AV}
fi
    dodoc ANNOUNCE CHANGES CREDITS INSTALL* LICENSE NEWS README*
    dodir /etc/rc.d/init.d

    insinto /etc/httpd
    doins ${FILESDIR}/httpd.conf

    exeinto /etc/rc.d/init.d
    newexe ${FILESDIR}/httpd.rc5 httpd
    dodir /etc/skel/public_html
}

pkg_config() {

  source ${ROOT}/etc/rc.d/config/functions

  if [ "$ServerName" = "" ]
  then
    ServerName=`uname -n`
  fi
  if [ "$ServerAdmin" = "" ]

  then
    ServerAdmin="webmaster\@$ServerName"
  fi

  # Make apache start at boot
  ${ROOT}/usr/sbin/rc-update add httpd

  # Set ServerName and ServerAdmin
  einfo "Setting Servername to $ServerName..."
  cp ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
  sed -e "s/^\#ServerName.*/ServerName $ServerName/" \
      -e "s/^ServerName.*/ServerName $ServerName/" \
      -e "s/^ServerAdmin.*/ServerAdmin $ServerAdmin/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf

}

pkg_prerm() {

  source ${ROOT}/etc/rc.d/config/functions
  if [ "$ROOT" = "/" ] 
  then
    if [ -f /var/run/httpd.pid ]
    then
      einfo "Stopping running daemon..."
      /etc/rc.d/init.d/httpd stop
    fi
  fi

}

