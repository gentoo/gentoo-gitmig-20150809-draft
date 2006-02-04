# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/mod_php/mod_php-4.4.0-r9.ebuild,v 1.8 2006/02/04 17:40:19 agriffis Exp $

IUSE="apache2"

KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 ~s390 sparc x86"

detectapache() {
	# DO NOT REPLICATE THIS IN ANY OTHER PACKAGE WITHOUT PORTAGE DEVS PERMISSION
	# IT IS BROKEN AND A TEMPORARY MEASURE!
	# YOU'VE BEEN WARNED.
	if [[ ${EBUILD_PHASE/depend} != ${EBUILD_PHASE} ]]; then
		APACHEVER=1
		return
	fi
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
#SRC_URI_BASE="http://downloads.php.net/ilia/" # for RC only

# BIG FAT WARNING!
# the php eclass requires the PHPSAPI setting!
# In this case the PHPSAPI setting is dependant on the detectapache function
# above this point as well!
inherit php-sapi eutils apache-module flag-o-matic

DESCRIPTION="Apache module for PHP"

DEPEND_EXTRA=">=net-www/apache-1.3.33-r10
			  apache2? ( >=net-www/apache-2.0.54-r30 )"
DEPEND="${DEPEND} ${DEPEND_EXTRA}"
RDEPEND="${RDEPEND} ${DEPEND_EXTRA}"
IUSE="${IUSE} debug"
# for this revision only
PDEPEND=">=${PHP_PROVIDER_PKG}-4.4.0"
PROVIDE="${PROVIDE} virtual/httpd-php"

# fixed PCRE library for security issues, bug #102373
SRC_URI="${SRC_URI} http://gentoo.longitekk.com/php-pcrelib-new-secpatch.tar.bz2"

# generalize some apache{,2} vars (defined by apache-module.eclass)
if [ -n ${USE_APACHE2} ]; then
	APACHE_MODULESDIR=${APACHE2_MODULESDIR}
	APACHE_CONFDIR=${APACHE2_CONFDIR}
else
	APACHE_MODULESDIR=${APACHE_MODULESDIR}
	APACHE_CONFDIR=${APACHE_CONFDIR}
fi

# Add a 'return 0' as we DON'T want the return code checked
pkg_setup() {
	use debug && einfo "Installing in SLOT=${SLOT}"
	return 0
}

src_unpack() {
	multiinstwarn
	detectapache domsg
	php-sapi_src_unpack
	if [ "${ARCH}" == "amd64" ] ; then
		epatch ${FILESDIR}/mod_php-4.3.4-amd64hack.diff
	fi

	# bug fix for security problem - bug #39952
	# second revision as the apache2 stuff was resolved upstream
	epatch ${FILESDIR}/mod_php-4.3.5-apache1security.diff

	# stop php from activing the apache config, as we will do that ourselves
	for i in configure sapi/apache/config.m4 sapi/apache2filter/config.m4 sapi/apache2handler/config.m4; do
		sed -i.orig -e 's,-i -a -n php4,-i -n php4,g' $i
	done

	# fix imap symlink creation, bug #105351
	use imap && epatch ${FILESDIR}/php4.4.0-imap-symlink.diff

	# patch to fix pspell extension, bug #99312 (new patch by upstream)
	use spell && epatch "${FILESDIR}/php4.4.0-pspell-ext-segf.patch"

	# patch to fix safe_mode bypass in GD extension, bug #109669
	if use gd || use gd-external ; then
		epatch "${FILESDIR}/php4.4.0-gd_safe_mode.patch"
	fi

	# patch fo fix safe_mode bypass in CURL extension, bug #111032
	use curl && epatch "${FILESDIR}/php4.4.0-curl_safemode.patch"

	# patch $GLOBALS overwrite vulnerability, bug #111011 and bug #111014
	epatch "${FILESDIR}/php4.4.0-globals_overwrite.patch"

	# patch phpinfo() XSS vulnerability, bug #111015
	epatch "${FILESDIR}/php4.4.0-phpinfo_xss.patch"

	# patch open_basedir directory bypass, bug #102943
	epatch "${FILESDIR}/php4.4.0-fopen_wrappers.patch"

	# patch to fix session.save_path segfault and other issues in
	# the apache2handler SAPI, bug #107602
	epatch "${FILESDIR}/php4.4.0-session_save_path-segf.patch"

	# we need to unpack the files here, the eclass doesn't handle this
	cd ${WORKDIR}
	unpack php-pcrelib-new-secpatch.tar.bz2
	cd ${S}

	# patch to fix PCRE library security issues, bug #102373
	epatch ${FILESDIR}/php4.4.0-pcre-security.patch

	# sobstitute the bundled PCRE library with a fixed version for bug #102373
	einfo "Updating bundled PCRE library"
	rm -rf ${S}/ext/pcre/pcrelib && mv -f ${WORKDIR}/pcrelib-new ${S}/ext/pcre/pcrelib || die "Unable to update the bundled PCRE library"
}

setup_environ() {
	append-flags `apr-config --cppflags --cflags`
}

src_compile() {
	setup_environ

	# Every Apache2 MPM EXCEPT prefork needs Zend Thread Safety
	if [ -n "${USE_APACHE2}" ]; then
		APACHE2_MPM="`/usr/sbin/apache2 -l | egrep 'worker|perchild|leader|threadpool|prefork'|cut -d. -f1|sed -e 's/^[[:space:]]*//g;s/[[:space:]]+/ /g;'`"
		einfo "Apache2 MPM: ${APACHE2_MPM}"
		case "${APACHE2_MPM}" in
			*prefork*) ;;
			*peruser*) ;;
			*) myconf="${myconf} --enable-experimental-zts" ; ewarn "Enabling ZTS for Apache2 MPM" ;;
		esac;
	fi

	#use apache2
	myconf="${myconf} --with-apxs${USE_APACHE2}=/usr/sbin/apxs${USE_APACHE2}"

	# Do not build CLI SAPI module.
	myconf="${myconf} --disable-cli --without-pear"

	php-sapi_src_compile
}

src_install() {
	PHP_INSTALLTARGETS="install"
	php-sapi_src_install

	dodir ${APACHE_CONFDIR}
	dodir ${PHPINIDIRECTORY}

	einfo "Cleaning up a little"
	rm -rf ${D}${APACHE_MODULESDIR}/libphp4.so

	exeinto ${APACHE_MODULESDIR}
	einfo "Installing mod_php shared object now"
	doexe .libs/libphp4.so

	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Installing a Apache2 config for PHP (70_mod_php.conf)"
		insinto ${APACHE2_MODULES_CONFDIR}
		doins ${FILESDIR}/4.4.0-a2/70_mod_php.conf
	else
		einfo "Installing a Apache config for PHP (70_mod_php.conf)"
		insinto ${APACHE1_MODULES_CONFDIR}
		doins ${FILESDIR}/4.4.0-a1/70_mod_php.conf
	fi
}

multiinstwarn() {
	ewarn "Due to some previous bloopers with PHP and slotting, you may have"
	ewarn "multiple instances of mod_php installed. Please look at the autoclean"
	ewarn "output at the end of the emerge and unmerge all but relevant"
	ewarn "instances."
}

apache2fix() {
	if egrep -q -- '-D PHP\>' /etc/conf.d/apache2; then
		einfo "Attemping to update /etc/conf.d/apache2 automatically for the PHP/PHP4 change."
		local oldfile="/etc/conf.d/apache2.old.`date +%Y%m%d%H%M%S`"
		cp /etc/conf.d/apache2 ${oldfile}
		sed -re 's,-D PHP\>,-D PHP4,g' ${oldfile}  <${oldfile} >/etc/conf.d/apache2
	fi
}


pkg_preinst() {
	multiinstwarn
	[ "${APACHEVER}" -eq '2' ] && apache2fix
	php-sapi_pkg_preinst
}

pkg_postinst() {
	php-sapi_pkg_postinst
	multiinstwarn
	APACHE1_MOD_DEFINE="PHP4"
	APACHE1_MOD_CONF="70_mod_php.conf"
	APACHE2_MOD_DEFINE="PHP4"
	APACHE2_MOD_CONF="70_mod_php.conf"
	apache-module_pkg_postinst
}
