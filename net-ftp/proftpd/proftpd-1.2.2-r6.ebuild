# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Donny Davies <woodchip@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/proftpd/proftpd-1.2.2-r6.ebuild,v 1.1 2001/09/08 18:35:01 woodchip Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An advanced and very configurable FTP server"
SRC_URI="ftp://www.linuxceptional.com/proftpd/distrib/source/${P}.tar.bz2"
HOMEPAGE="http://www.proftpd.net/"

DEPEND="virtual/glibc
        pam? ( >=sys-libs/pam-0.75 )
        mysql? ( >=dev-db/mysql-3.23.26 )
        ldap? ( >=net-nds/openldap-1.2.11 )
        postgres? ( >=dev-db/postgresql-7.1 )"

src_compile() {
    local modules myconf
    modules="mod_ratio:mod_readme:mod_linuxprivs"

    use pam && modules="$modules:mod_pam"
    use ldap && modules="$modules:mod_ldap"

    if [ "`use mysql`" ]; then
        modules="$modules:mod_sql:mod_sql_mysql"
    elif [ "`use postgres`" ]; then
        modules="$modules:mod_sql:mod_sql_postgres"
        myconf="${myconf} --with-includes=/usr/include/postgresql"
    fi

    ./configure --host=${CHOST} --prefix=/usr --sbindir=/usr/sbin \
	--sysconfdir=/etc/proftpd --localstatedir=/var/run \
	--mandir=/usr/share/man --with-modules=$modules \
	--disable-sendfile --enable-shadow --enable-autoshadow $myconf
    assert
    make || die
}

src_install() {                               
    make install prefix=${D}/usr sysconfdir=${D}/etc/proftpd \
	mandir=${D}/usr/share/man localstatedir=${D}/var/run \
	sbindir=${D}/usr/sbin || die

    dodoc contrib/README.mod_sql ${FILESDIR}/proftpd.conf
    dodoc COPYING CREDITS ChangeLog NEWS README*
    cd doc ; dodoc API Changes* license.txt GetConf
    dodoc ShowUndocumented Undocumented.txt development.notes
    docinto html ; dodoc *.html
    docinto rfc ; dodoc rfc/*.txt

    dodir /home/ftp
    dobin contrib/genuser.pl

    cd ${D}/etc/proftpd
    mv proftpd.conf proftpd.conf.distrib

    insinto /etc/proftpd
    newins ${FILESDIR}/proftpd.conf proftpd.conf.sample

    exeinto /etc/init.d
    newexe ${FILESDIR}/proftpd.rc6 proftpd
}
