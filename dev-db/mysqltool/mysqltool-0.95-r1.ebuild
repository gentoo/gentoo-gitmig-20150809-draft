# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltool/mysqltool-0.95-r1.ebuild,v 1.2 2002/07/23 03:08:12 rphillips Exp $

S=${WORKDIR}/MysqlTool-${PV}
DESCRIPTION="Web interface for managing one or more mysql server installations"
SRC_URI="http://www.dajoba.com/projects/mysqltool/MysqlTool-${PV}.tar.gz"
HOMEPAGE="http://www.dajoba.com/projects/mysqltool/"
DEPEND="virtual/glibc sys-devel/perl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="${DEPEND} >=net-www/apache-1.3.24-r1 >=dev-db/mysql-3.23.38
	dev-perl/CGI dev-perl/DBI dev-perl/DBD-mysql dev-perl/Crypt-Blowfish"

src_compile() {
	perl Makefile.PL || die
	make || die
	make test || die
}

src_install() {
	eval `perl '-V:installarchlib'`
	mkdir -p ${D}/$installarchlib

	perl Makefile.PL
	make \
		PREFIX=${D}/usr \
		INSTALLMAN3DIR=${D}/usr/share/man/man3 \
		INSTALLMAN1DIR=${D}/usr/share/man/man1 \
		install || die

	dodoc COPYING Changes MANIFEST README Upgrade

	# the cgi and images..
	dodir /home/httpd/htdocs/mysqltool
	cp -a htdocs/* ${D}/home/httpd/htdocs/mysqltool
	rm ${D}/home/httpd/htdocs/mysqltool/mysqltool.conf

	# the config file..
	insinto /etc/apache/conf/addon-modules
	doins htdocs/mysqltool.conf
	fowners apache.apache /etc/apache/conf/addon-modules/mysqltool.conf
	fperms 0600 /etc/apache/conf/addon-modules/mysqltool.conf

	# now fix its location in the main cgi..
	cp ${D}/home/httpd/htdocs/mysqltool/index.cgi \
		${D}/home/httpd/htdocs/mysqltool/index.cgi.orig
	sed -e "s:^\(require\).*:\1 '/etc/apache/conf/addon-modules/mysqltool.conf';:" \
		${D}/home/httpd/htdocs/mysqltool/index.cgi.orig > \
		${D}/home/httpd/htdocs/mysqltool/index.cgi
	rm ${D}/home/httpd/htdocs/mysqltool/index.cgi.orig
}
