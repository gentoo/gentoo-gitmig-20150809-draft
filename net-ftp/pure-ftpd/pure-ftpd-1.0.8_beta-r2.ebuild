# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.8_beta-r2.ebuild,v 1.1 2002/01/31 17:47:12 verwilst Exp $

S="${WORKDIR}/pure-ftpd-1.0.8"
SRC_URI="http://prdownloads.sourceforge.net/pureftpd/pure-ftpd-1.0.8-beta.tar.gz"
DESCRIPTION="Pure-FTPd is a fast, production-quality, standard-conformant FTP server"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam )
	mysql? ( >=dev-db/mysql )
	postgres? ( >=dev-db/postgresql )
	ldap? ( >=net-nds/openldap )"

src_compile() {
	local myconf
	cd ${S}
	use pam && myconf="${myconf} --with-pam"
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	use ldap && myconf="${myconf} --with-ldap"
	./configure --prefix=/usr --with-altlog --with-puredb		\
		--with-extauth --with-throttling --with-ratios		\
		--with-quotas --with-cookie		\
		--with-uploadscript --with-virtualhosts			\
		--with-virtualchroot --with-diraliases --with-ftpwho	\
		--host=${CHOST} ${myconf} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die
	mkdir -p ${D}/etc
	cp ${FILESDIR}/ftpusers ${D}/etc/ftpusers
	mkdir -p ${D}/etc/conf.d
	cp ${FILESDIR}/pure-ftpd.conf_d ${D}/etc/conf.d/pure-ftpd
	mkdir -p ${D}/etc/init.d
	cp ${FILESDIR}/pure-ftpd.rc6 ${D}/etc/init.d/pure-ftpd		
	chmod 755 ${D}/etc/init.d/pure-ftpd
	
}
