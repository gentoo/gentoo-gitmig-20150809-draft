# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_log_sql/mod_log_sql-1.97.ebuild,v 1.8 2004/09/03 23:24:08 pvdabeel Exp $

inherit eutils

DESCRIPTION="An Apache module for logging to an SQL (MySQL) database"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_log_sql/"
SRC_URI="http://www.outoforder.cc/downloads/mod_log_sql/${P}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=dev-db/mysql-3.23.15
	apache2? ( =net-www/apache-2* )
	!apache2? ( >=net-www/apache-1* )"

detectapache() {
	local domsg=
	[ -n "$1" ] && domsg=1
	HAVE_APACHE1=
	HAVE_APACHE2=
	has_version '=net-www/apache-1*' && HAVE_APACHE1=1
	has_version '=net-www/apache-2*' && HAVE_APACHE2=1

	[ -n "${HAVE_APACHE1}" ] && APACHEVER=1
	[ -n "${HAVE_APACHE2}" ] && APACHEVER=2
	[ -n "${HAVE_APACHE1}" ] && [ -n "${HAVE_APACHE2}" ] && APACHEVER='both'

	case "${APACHEVER}" in
		1) [ -n "${domsg}" ] && einfo 'Apache1 only detected' ;;
		2) [ -n "${domsg}" ] && einfo 'Apache2 only detected' ;;
	both)
		if use apache2; then
		[ -n "${domsg}" ] && einfo "Multiple Apache versions detected, using Apache2 (USE=apache2)"
		APACHEVER=2
			else
		[ -n "${domsg}" ] && einfo 'Multiple Apache versions detected, using Apache1 (USE=-apache2)'
		APACHEVER=1
		fi ;;
		*) if [ -n "${domsg}" ]; then
			MSG="Unknown Apache version!"; eerror $MSG ; die $MSG
		else
			die $MSG
		fi; ;;
		esac

	if [ "$APACHEVER" == "2" ]; then
		APXS="`which apxs2`"
		APACHE_MODULES_DIR=/usr/lib/apache2-extramodules
		CONFIG_FILE=${FILESDIR}/10_mod_log_sql_apache2.conf
		APACHE_MODULES_CONFIG_DIR=/etc/apache2/conf/modules.d
	else
		APXS="`which apxs`"
		APACHE_MODULES_DIR=/usr/lib/apache-extramodules
		CONFIG_FILE=${FILESDIR}/10_mod_log_sql.conf
		APACHE_MODULES_CONFIG_DIR=/etc/apache/conf/modules.d
	fi
}

src_compile() {
	detectapache
	myconf="--with-apxs=${APXS}"

	epatch ${FILESDIR}/mod_log_sql-1.97-gentoo.patch || die "Patch failed."
	use ssl && myconf="${myconf} --enable-ssl"
	./configure ${myconf}
	emake || die
}

src_install() {
	detectapache
	exeinto ${APACHE_MODULES_DIR}
	doexe .libs/${PN}.so .libs/mod_log_sql_mysql.so

	use ssl && doexe .libs/mod_log_sql_ssl.so

	cat ${CONFIG_FILE} | sed -e "s#machine_id#`hostname -f`#" > 10_mod_log_sql.conf
	insinto ${APACHE_MODULES_CONFIG_DIR}
	doins 10_mod_log_sql.conf

	dodoc AUTHORS CHANGELOG INSTALL LICENSE TODO Documentation/README Documentation/manual.html Documentation/manual.xml
	docinto contrib
	dodoc contrib/create_tables.sql contrib/make_combined_log.pl contrib/mysql_import_combined_log.pl
}

pkg_postinst() {
	detectapache
	if [ "$APACHEVER" == "2" ]; then
	        einfo "Please add '-D LOG_SQL' to your /etc/conf.d/apache2 APACHE2_OPTS setting."
	else
	        einfo "Please add '-D LOG_SQL' to your /etc/conf.d/apache APACHE_OPTS setting"
	fi

	einfo "Do not forget to adapt ${APACHE_MODULES_CONFIG_DIR}/10_mod_log_sql.conf to your needs."
	einfo "See /usr/share/doc/${PF}/contrib/create_tables.sql.gz on how to create logging tables.\n"
}
