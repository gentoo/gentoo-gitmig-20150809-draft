# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltool/mysqltool-0.95-r1.ebuild,v 1.10 2002/12/07 05:56:12 jmorgan Exp $

inherit perl-module

S=${WORKDIR}/MysqlTool-${PV}
DESCRIPTION="Web interface for managing one or more mysql server installations"
SRC_URI="http://www.dajoba.com/projects/mysqltool/MysqlTool-${PV}.tar.gz"
HOMEPAGE="http://www.dajoba.com/projects/mysqltool/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

DEPEND="virtual/glibc
	sys-devel/perl"
RDEPEND="${DEPEND}
	>=net-www/apache-1.3.24-r1
	>=dev-db/mysql-3.23.38
	dev-perl/CGI
	dev-perl/Apache-DBI
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Crypt-Blowfish"

APACHE_ROOT="`grep '^DocumentRoot' /etc/apache/conf/apache.conf | cut -d\  -f2`"
[ -z "${APACHE_ROOT}" ] && APACHE_ROOT="/home/httpd/htdocs"

src_install() {
	eval `perl '-V:installarchlib'`
	dodir /$installarchlib

	cp ${S}/Makefile ${S}/Makefile.orig
	cat ${S}/Makefile | sed -e "s!INSTALLMAN1DIR = /usr/share/man/man1!INSTALLMAN1DIR = ${D}/usr/share/man/man1!" -e "s!INSTALLMAN3DIR = /usr/share/man/man3!INSTALLMAN3DIR = ${D}/usr/share/man/man3!" > ${S}/Makefile.gentoo
	mv ${S}/Makefile.gentoo ${S}/Makefile

	make install || die

	dodoc COPYING Changes MANIFEST README Upgrade

	# the cgi and images..
	dodir ${APACHE_ROOT}/mysqltool
	cp -a htdocs/* ${D}${APACHE_ROOT}/mysqltool
	rm ${D}${APACHE_ROOT}/mysqltool/mysqltool.conf

	# the config file..
	insinto /etc/apache/conf/addon-modules
	doins htdocs/mysqltool.conf
	fowners apache.apache /etc/apache/conf/addon-modules/mysqltool.conf
	fperms 0600 /etc/apache/conf/addon-modules/mysqltool.conf

	# now fix its location in the main cgi..
	cp ${D}${APACHE_ROOT}/mysqltool/index.cgi \
		${D}${APACHE_ROOT}/mysqltool/index.cgi.orig
	sed -e "s:^\(require\).*:\1 '/etc/apache/conf/addon-modules/mysqltool.conf';:" \
		${D}${APACHE_ROOT}/mysqltool/index.cgi.orig > \
		${D}${APACHE_ROOT}/mysqltool/index.cgi
	rm ${D}${APACHE_ROOT}/mysqltool/index.cgi.orig
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
