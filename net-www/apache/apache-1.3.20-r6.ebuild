# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/apache/apache-1.3.20-r6.ebuild,v 1.1 2001/09/06 08:00:57 woodchip Exp $

AV="1.3.20"
MSV="2.8.4"

A="apache_${AV}.tar.gz mod_ssl-${MSV}-${AV}.tar.gz"
S=${WORKDIR}/apache_${AV}
DESCRIPTION="The Apache Web Server"
HOMEPAGE="http://www.apache.org http://www.modssl.org"
SRC_URI="http://httpd.apache.org/dist/httpd/apache_${AV}.tar.gz
         ftp://ftp.modssl.org/source/mod_ssl-${MSV}-${AV}.tar.gz"

DEPEND="virtual/glibc
        >=sys-libs/db-3.2.3h-r3 =sys-libs/db-1.85-r1
        ssl? ( >=dev-libs/openssl-0.9.6b )"

src_compile() {

    local myconf
    export SSL_BASE=SYSTEM
    export CFLAGS="${CFLAGS} -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
    export RULE_EXPAT=NO

    if [ "`use ssl`" ]; then
	myconf="${myconf} --enable-module=ssl"
	cd ${S}/../mod_ssl-${MSV}-${AV}
	./configure --with-apache=${S} --with-ssl=SYSTEM || die
	cd ${S}
    fi

    ./configure --prefix=/usr/local/httpd --bindir=/usr/bin \
	--sbindir=/usr/sbin --datadir=/usr/local/httpd \
	--sysconfdir=/etc/httpd --libexecdir=/usr/lib/apache \
	--mandir=/usr/share/man --logfiledir=/var/log/apache --localstatedir=/var/lock \
	--proxycachedir=/var/cache/httpd --includedir=/usr/include/apache \
	--enable-module=all \
	--enable-shared=max --suexec-caller=wwwrun \
	--suexec-userdir=public_html --suexec-uidmin=96 \
	--suexec-gidmin=96 --suexec-safepath="/bin:/usr/bin" \
	--disable-rule=EXPAT --with-perl=/usr/bin/perl ${myconf}
    assert "bad configure"

    make || die "compile problem"
    use ssl && ( make certificate TYPE=dummy || die "make ssl certificate failed" )
}

src_install() {

    make install-quiet root=${D} || die
    dodoc ABOUT_APACHE Announcement INSTALL* KEYS LICENSE* README* WARNING* ${FILESDIR}/httpd.conf
    dosed "s:^PIDFILE.*:PIDFILE=/var/run/httpd.pid:" /usr/sbin/apachectl
    dosed "s:/usr/local/bin/perl5:/usr/bin/perl:" \
	/usr/local/httpd/htdocs/manual/search/manual-index.cgi

    if [ "`use ssl`" ] ; then
	cd ../mod_ssl-${MSV}-${AV}
	docinto mod_ssl
	dodoc ANNOUNCE CHANGES CREDITS INSTALL* LICENSE NEWS README*
    fi

    exeinto /etc/init.d
    newexe ${FILESDIR}/httpd.rc6 httpd
    insinto /etc/httpd
    doins ${FILESDIR}/httpd.conf
}

pkg_config() {

    #${ROOT}/sbin/rc-update add httpd default

    if [ "$ServerName" = "" ] ; then
	ServerName=`uname -n`
    fi
    if [ "$ServerAdmin" = "" ] ; then
	ServerAdmin="webmaster\@$ServerName"
    fi

    mv ${ROOT}/etc/httpd/httpd.conf ${ROOT}/etc/httpd/httpd.conf.orig
    sed -e "s/^\#ServerName.*/ServerName $ServerName/" \
	-e "s/^ServerName.*/ServerName $ServerName/" \
	-e "s/^ServerAdmin.*/ServerAdmin $ServerAdmin/" \
	${ROOT}/etc/httpd/httpd.conf.orig > ${ROOT}/etc/httpd/httpd.conf
}

pkg_prerm() {

    if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/httpd ] ; then
	/etc/init.d/httpd stop
    fi
    return # dont fail
}

pkg_preinst() {

    if [ "$ROOT" = "/" ] && [ -e /dev/shm/.init.d/started/httpd ] ; then
	/etc/init.d/httpd stop
    fi
    return # dont fail
}
