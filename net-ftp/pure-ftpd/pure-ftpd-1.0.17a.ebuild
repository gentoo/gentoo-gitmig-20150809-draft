# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/pure-ftpd/pure-ftpd-1.0.17a.ebuild,v 1.1 2004/01/22 16:41:08 raker Exp $

IUSE="pam mysql postgres ldap ssl"

DESCRIPTION="Pure-FTPd is a fast, production-quality, standard-conformant FTP server"
SRC_URI="ftp://ftp.pureftpd.org/pub/pure-ftpd/releases/${P}.tar.bz2"
HOMEPAGE="http://www.pureftpd.org/"

SLOT="0"
LICENSE="BSD" # Changed from GPL-2 to BSD 06/09/2003
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND="virtual/glibc
	pam? ( >=sys-libs/pam-0.75 )
	mysql? ( >=dev-db/mysql-3* )
	postgres? ( >=dev-db/postgresql-7.2.2 )
	ldap? ( >=net-nds/openldap-2.0.25 )
	ssl? ( >=dev-libs/openssl-0.9.6g )"

src_compile() {
	local myconf=""

	use pam && myconf="${myconf} --with-pam"
	use ldap && myconf="${myconf} --with-ldap"
	use mysql && myconf="${myconf} --with-mysql"
	use postgres && myconf="${myconf} --with-pgsql"
	use ssl && myconf="${myconf} --with-tls"

	econf \
		--with-altlog --with-extauth \
		--with-puredb --with-cookie \
		--with-throttling --with-ratios \
		--with-quotas --with-ftpwho \
		--with-uploadscript --with-virtualhosts \
		--with-virtualchroot --with-diraliases \
		--with-peruserlimits ${myconf}

	emake || die "compile problem"
}

src_install() {
	einstall

	dodoc AUTHORS CONTACT COPYING ChangeLog FAQ HISTORY INSTALL README* NEWS

	dodir /etc/{conf.d,init.d}
	cp ${FILESDIR}/ftpusers ${D}/etc/ftpusers
	cp ${FILESDIR}/pure-ftpd.conf_d ${D}/etc/conf.d/pure-ftpd

	use pam && insinto /etc/pam.d && doins pam/pure-ftpd

	exeinto /etc/init.d
	newexe ${FILESDIR}/pure-ftpd.rc6-r1 pure-ftpd

	insopts -m 644
	insinto /etc/xinetd.d
	newins ${FILESDIR}/pure-ftpd.xinetd pure-ftpd

	if [ `use ldap` ]; then
		dodir /etc/openldap/schema
		insinto /etc/openldap/schema
		doins pureftpd.schema
		insinto /etc/openldap
		doins pureftpd-ldap.conf
	fi
}

pkg_postinst() {
	einfo "Before starting Pure-FTPd, you have to edit the /etc/conf.d/pure-ftpd file."
	echo
	ewarn "It's *really* important to read the README provided with Pure-FTPd."
	ewarn "Check out - http://www.pureftpd.org/README"
	ewarn "And for SSL/TLS help - http://www.pureftpd.org/README.TLS"
}
