# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/mod_php/mod_php-5.0.2.ebuild,v 1.4 2004/11/21 07:05:21 kingtaco Exp $

IUSE="${IUSE} apache2"

KEYWORDS="~ia64 ~ppc ~x86 ~ppc64 ~amd64"
PROVIDE="virtual/php-${PV} virtual/httpd-php-${PV}"

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
	2) [ -n "${domsg}" ] && einfo 'Apache2 only detected';;
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
			APACHEVER=0
	   fi; ;;
	esac
}

detectapache

SLOT="${APACHEVER}"
[ "${APACHEVER}" -eq '2' ] && USE_APACHE2='2' || USE_APACHE2=''

PHPSAPI="apache${APACHEVER}"
MY_P="php-${PV}"

# BIG FAT WARNING!
# the php eclass requires the PHPSAPI setting!
# In this case the PHPSAPI setting is dependant on the detectapache function
# above this point as well!
inherit php5-sapi eutils

DESCRIPTION="Apache module for PHP 5"

# provides all base PHP extras (eg PEAR, extension building stuff)
DEPEND_EXTRA=">=${PHP_PROVIDER_PKG}-5.0.2
			  >=net-www/apache-1.3.26-r2
			  apache2? ( >=net-www/apache-2.0.50 )
			  || ( >=net-www/apache-1.3.26-r2 >=net-www/apache-2.0.50 )"
DEPEND="${DEPEND} ${DEPEND_EXTRA}"
RDEPEND="${RDEPEND} ${DEPEND_EXTRA}"
IUSE="${IUSE} debug"

# Add a 'return 0' as we DON'T want the return code checked
pkg_setup() {
	use debug && einfo "Installing in SLOT=${SLOT}"
	return 0
}

src_unpack() {
	detectapache domsg

	php5-sapi_src_unpack
}

src_compile() {
	# Every Apache2 MPM EXCEPT prefork needs Zend Thread Safety
	if [ -n "${USE_APACHE2}" ]; then
		APACHE2_MPM="`/usr/sbin/apache2 -l |egrep 'worker|perchild|leader|threadpool|prefork'|cut -d. -f1|sed -e 's/^[[:space:]]*//g;s/[[:space:]]+/ /g;'`"
		einfo "Apache2 MPM: ${APACHE2_MPM}"
		case "${APACHE2_MPM}" in
			*prefork*) ;;
			*) my_conf="${my_conf} --enable-experimental-zts" ; ewarn "Enabling ZTS for Apache2 MPM" ;;
		esac;
	fi

	#use apache2 \
	my_conf="${my_conf} --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"

	php5-sapi_src_compile
}


src_install() {
	PHP_INSTALLTARGETS="install"
	php5-sapi_src_install

	einfo "Adding extra symlink to Apache${USE_APACHE2} extramodules for PHP"
	dosym /usr/lib/apache${USE_APACHE2}-extramodules ${PHP_INI_DIR}/lib

	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Installing a Apache2 config for PHP (70_mod_php5.conf)"
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/70_mod_php5.conf
	else
		einfo "Installing a Apache config for PHP (mod_php5.conf)"
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_php5.conf
		dosym ${PHP_INI_DIR}/${PHP_INI_FILE} /etc/apache/conf/addon-modules/${PHP_INI_FILE}
	fi
}

apache2msg() {
	einfo "Edit /etc/conf.d/apache2 and add \"-D PHP5\" to APACHE2_OPTS"
	ewarn "This is a change from the old \"-D PHP4\"!"
}

pkg_postinst() {
	einfo "To have Apache run php programs, please do the following:"
	if [ -n "${USE_APACHE2}" ]; then
		apache2msg
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D PHP5\" to APACHE_OPTS"
		einfo "That will include the php mime types in your configuration"
		einfo "automagically and setup Apache to load php when it starts."
		ewarn "This is a change from the old \"-D PHP4\"!"
	fi
}

pkg_config() {
	if [ -n "${USE_APACHE2}" ]; then
		apache2msg
	else
		${ROOT}/usr/sbin/apacheaddmod \
			${ROOT}/etc/apache/conf/apache.conf \
			extramodules/libphp5.so mod_php5.c php5_module \
			before=perl define=PHP5 addconf=conf/addon-modules/mod_php.conf
			:;
	fi
}
