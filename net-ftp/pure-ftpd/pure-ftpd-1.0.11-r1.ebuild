# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.11-r1.ebuild,v 1.4 2002/07/17 09:39:57 seemant Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Pure-FTPd is a fast, production-quality, standard-conformant FTP server"
SRC_URI="mirror://sourceforge/pureftpd/${P}.tar.bz2"
HOMEPAGE="http://www.pureftpd.org/"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3.23.49 )
	postgres? ( >=dev-db/postgresql-7.2 )
	ldap? ( >=net-nds/openldap-2.0.21 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_compile() {

	local myconf
	use pam && myconf="${myconf} --with-pam"
	use ldap && myconf="${myconf} --with-ldap"
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	
	./configure --prefix=/usr --mandir=/usr/share/man \
		--with-altlog --with-extauth \
		--with-puredb --with-cookie \
		--with-throttling --with-ratios \
		--with-quotas --with-ftpwho \
		--with-uploadscript --with-virtualhosts \
		--with-virtualchroot --with-diraliases \
		--build=${CHOST} ${myconf} || die "configure failed"

	emake || die "compile problem"
}

src_install() {

	make \
	prefix=${D}/usr \
	mandir=${D}/usr/share/man \
	install || die
	dodoc AUTHORS CONTACT COPYING ChangeLog
	dodoc FAQ HISTORY INSTALL README* NEWS
	mkdir -p ${D}/etc
        cp ${FILESDIR}/ftpusers ${D}/etc/ftpusers
        mkdir -p ${D}/etc/conf.d
        cp ${FILESDIR}/pure-ftpd.conf_d ${D}/etc/conf.d/pure-ftpd
	if [ "`use pam`" ] ; then
	insinto /etc/pam.d ; doins pam/{ftplockout,pure-ftpd}
	fi
	mkdir -p ${D}/etc/init.d
        cp ${FILESDIR}/pure-ftpd.rc6 ${D}/etc/init.d/pure-ftpd
        chmod 755 ${D}/etc/init.d/pure-ftpd

}

