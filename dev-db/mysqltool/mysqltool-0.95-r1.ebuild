# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltool/mysqltool-0.95-r1.ebuild,v 1.19 2005/02/14 05:49:24 robbat2 Exp $

inherit perl-module

S=${WORKDIR}/MysqlTool-${PV}
DESCRIPTION="Web interface for managing one or more mysql server installations"
SRC_URI="http://www.brouhaha.com/~eric/software/mysqltool/download/MysqlTool-${PV}.tar.gz"
HOMEPAGE="http://www.brouhaha.com/~eric/software/mysqltool/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
IUSE=""

DEPEND="virtual/libc
	dev-lang/perl"
RDEPEND="${DEPEND}
	>=net-www/apache-1.3.24-r1
	>=dev-db/mysql-3.23.38
	dev-perl/CGI
	dev-perl/Apache-DBI
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Crypt-Blowfish"

src_install() {
	eval `perl '-V:installarchlib'`
	dodir /$installarchlib

	cp ${S}/Makefile ${S}/Makefile.orig
	cat ${S}/Makefile | sed -e "s!INSTALLMAN1DIR = /usr/share/man/man1!INSTALLMAN1DIR = ${D}/usr/share/man/man1!" -e "s!INSTALLMAN3DIR = /usr/share/man/man3!INSTALLMAN3DIR = ${D}/usr/share/man/man3!" > ${S}/Makefile.gentoo
	mv ${S}/Makefile.gentoo ${S}/Makefile

	make install || die

	dodoc COPYING Changes MANIFEST README Upgrade

	# the cgi and images..
	dodir /home/httpd/htdocs/mysqltool
	cp -a htdocs/* ${D}/home/httpd/htdocs/mysqltool
	rm ${D}/home/httpd/htdocs/mysqltool/mysqltool.conf

	# the config file..
	insinto /etc/apache/conf/addon-modules
	doins htdocs/mysqltool.conf
	fowners apache:apache /etc/apache/conf/addon-modules/mysqltool.conf
	fperms 0600 /etc/apache/conf/addon-modules/mysqltool.conf

	# now fix its location in the main cgi..
	cp ${D}/home/httpd/htdocs/mysqltool/index.cgi \
		${D}/home/httpd/htdocs/mysqltool/index.cgi.orig
	sed -e "s:^\(require\).*:\1 '/etc/apache/conf/addon-modules/mysqltool.conf';:" \
		${D}/home/httpd/htdocs/mysqltool/index.cgi.orig > \
		${D}/home/httpd/htdocs/mysqltool/index.cgi
	rm ${D}/home/httpd/htdocs/mysqltool/index.cgi.orig
}

pkg_postinst() {
	einfo "Please add the following to commonapache.conf:"
	einfo "PerlRequire {apache_root}/conf/mysqltool.conf"
	einfo "<Directory {apache_document_root}/htdocs/mysqltool>"
	einfo "Options ExecCGI"
	einfo "<Files *.cgi>"
	einfo "SetHandler perl-script"
	einfo "PerlHandler MysqlTool"
	einfo "</Files>"
	einfo "</Directory>"
}
