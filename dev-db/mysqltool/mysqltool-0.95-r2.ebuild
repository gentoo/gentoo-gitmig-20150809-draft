# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mysqltool/mysqltool-0.95-r2.ebuild,v 1.4 2003/05/12 16:08:26 robbat2 Exp $

inherit perl-module

S=${WORKDIR}/MysqlTool-${PV}
DESCRIPTION="Web interface for managing one or more mysql server installations"
SRC_URI="http://www.dajoba.com/projects/mysqltool/MysqlTool-${PV}.tar.gz"
HOMEPAGE="http://www.dajoba.com/projects/mysqltool/"
IUSE="apache2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~hppa ~mips ~arm ~ppc ~alpha"

DEPEND="virtual/glibc
	dev-lang/perl
	>=dev-db/mysql-3.23.38
	dev-perl/CGI
	dev-perl/Apache-DBI
	dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/Crypt-Blowfish"
RDEPEND="${DEPEND}
	|| ( >=net-www/apache-1.3.24-r1 
		 apache2? ( >=net-www/apache-2.0.45 ) 
	    )"

src_install() {
	eval `perl '-V:installarchlib'`
	dodir /$installarchlib

	cp ${S}/Makefile ${S}/Makefile.orig
	cat ${S}/Makefile | sed -e "s!INSTALLMAN1DIR = /usr/share/man/man1!INSTALLMAN1DIR = ${D}/usr/share/man/man1!" -e "s!INSTALLMAN3DIR = /usr/share/man/man3!INSTALLMAN3DIR = ${D}/usr/share/man/man3!" > ${S}/Makefile.gentoo
	mv ${S}/Makefile.gentoo ${S}/Makefile

	make install || die

	dodoc COPYING Changes MANIFEST README Upgrade
	
	local __apache_server_root__ 
	if [ "`use apache2`" ]; then
		__apache_server_root__="/etc/apache2"
	else
		__apache_server_root__="/etc/apache"
	fi;
	__apache_conf_dir__=${__apache_server_root__}/conf
	local __apache_document_root__
	__apache_document_root__=`grep "^DocumentRoot" ${__apache_conf_dir__}/*.conf -h | cut -d' ' -f2`
	local __apache_modules_conf_dir__
	if [ "`use apache2`" ]; then
		__apache_modules_conf_dir__="${__apache_conf_dir__}/modules.d"
		else
		__apache_modules_conf_dir__="${__apache_conf_dir__}/addon-modules"
	fi;

	# the cgi and images..
	dodir ${__apache_document_root__}/mysqltool
	cp -a htdocs/* ${D}/${__apache_document_root__}/mysqltool
	rm ${D}/${__apache_document_root__}/mysqltool/mysqltool.conf

	# the config file..
	local apacheconfbase
	apacheconfbase=${FILESDIR}/90_mysqltool.conf.m4
	insinto ${__apache_modules_conf_dir__}
	cp ${S}/htdocs/mysqltool.conf ${S}/htdocs/mysqltool.pl
	doins htdocs/mysqltool.pl
	fowners apache.apache ${__apache_modules_conf_dir__}/mysqltool.pl
	fperms 0600 ${__apache_modules_conf_dir__}/mysqltool.pl
	m4 -D__APACHE_SERVER_ROOT__=${__apache_server_root__} -D__APACHE_DOCUMENT_ROOT__=${__apache_document_root__} -D__APACHE_MODULES_CONF_DIR__=${__apache_modules_conf_dir__} ${apacheconfbase} >${D}/${__apache_modules_conf_dir__}/`basename ${apacheconfbase} .m4`

	# now fix its location in the main cgi..
	cp ${D}/${__apache_document_root__}/mysqltool/index.cgi \
		${D}/${__apache_document_root__}/mysqltool/index.cgi.orig
	sed -e "s:^\(require\).*:\1 '${__apache_modules_conf_dir__}/mysqltool.pl';:" \
		${D}/${__apache_document_root__}/mysqltool/index.cgi.orig > \
		${D}/${__apache_document_root__}/mysqltool/index.cgi
	rm ${D}/${__apache_document_root__}/mysqltool/index.cgi.orig
}

pkg_postinst() {
	einfo "To have Apache support MySQLTool, please do the following:"
	local f
	if [ "`use apache2`" ] ; then
		f='2'
	else
		f=''
	fi
	einfo "Edit /etc/conf.d/apache${f} and add \"-D MYSQLTOOL\" to APACHE${f}_OPTS"
}
