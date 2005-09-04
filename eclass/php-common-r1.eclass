# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/php-common-r1.eclass,v 1.1 2005/09/04 10:54:53 stuart Exp $

# ########################################################################
#
# eclass/php-common-r1.eclass
#				Contains common functions which are shared between the
#				PHP4 and PHP5 packages
#
#				USE THIS ECLASS FOR THE "CONSOLIDATED" PACKAGES
#
#				Based on robbat2's work on the php4 sapi eclass
#				Based on stuart's work on the php5 sapi eclass
#
# Maintainer:
#				php-bugs@gentoo.org
#
# ########################################################################

# ########################################################################
# CFLAG SANITY
# ########################################################################

php_check_cflags() {
	# filter the following from C[XX]FLAGS regardless, as apache won't be
	# supporting LFS until 2.2 is released and in the tree.  Fixes bug #24373.
	filter-flags "-D_FILE_OFFSET_BITS=64"
	filter-flags "-D_FILE_OFFSET_BITS=32"
	filter-flags "-D_LARGEFILE_SOURCE=1"
	filter-flags "-D_LARGEFILE_SOURCE"

	#fixes bug #14067
	# changed order to run it in reverse for bug #32022 and #12021
	replace-flags "-march=k6-3" "-march=i586"
	replace-flags "-march=k6-2" "-march=i586"
	replace-flags "-march=k6" "-march=i586"
}

# ########################################################################
# IMAP SUPPORT
# ########################################################################

php_check_imap() {
	if ! useq imap ; then
		return
	fi

	if useq ssl ; then
		if ! built_with_use virtual/imap-c-client ssl ; then
			eerror
			eerror "IMAP+SSL requested, but your IMAP libraries are built without SSL!"
			eerror
			die "Please recompile IMAP libraries w/ SSL support enabled"
		fi
	fi
}

# ########################################################################
# JAVA EXTENSION SUPPORT
#
# The bundled java extension is unique to PHP4 at the time of writing, but
# there is now the PHP-Java-Bridge that works under both PHP4 and PHP5.
# ########################################################################

php_uses_java() {
	if ! useq java ; then
		return 1
	fi

	if useq alpha || useq amd64 ; then
		return 1
	fi

	return 0
}

php_check_java() {
	if ! php_uses_java ; then
		return
	fi

	JDKHOME="`java-config --jdk-home`"
	NOJDKERROR="You need to use java-config to set your JVM to a JDK!"
	if [ -z "${JDKHOME}" ] || [ ! -d "${JDKHOME}" ]; then
		eerror "${NOJDKERROR}"
		die "${NOJDKERROR}"
	fi

	# stuart@gentoo.org - 2003/05/18
	# Kaffe JVM is not a drop-in replacement for the Sun JDK at this time

	if echo ${JDKHOME} | grep kaffe > /dev/null 2>&1 ; then
		eerror
		eerror "PHP will not build using the Kaffe Java Virtual Machine."
		eerror "Please change your JVM to either Blackdown or Sun's."
		eerror
		eerror "To build PHP without Java support, please re-run this emerge"
		eerror "and place the line:"
		eerror "  USE='-java'"
		eerror "in front of your emerge command; e.g."
		eerror "  USE='-java' emerge mod_php"
		eerror
		eerror "or edit your USE flags in /etc/make.conf"
		die "Kaffe JVM not supported"
	fi

	JDKVER=$(java-config --java-version 2>&1 | awk '/^java version/ { print $3
}' | xargs )
	einfo "Active JDK version: ${JDKVER}"
	case ${JDKVER} in
		1.4.*) ;;
		1.5.*) ewarn "Java 1.5 is NOT supported at this time, and might not work." ;;
		*) eerror "A Java 1.4 JDK is required for Java support in PHP." ; die ;;
	esac
}

php_install_java() {
	if ! php_uses_java ; then
		return
	fi

	# we put these into /usr/lib so that they cannot conflict with
	# other versions of PHP (e.g. PHP 4 & PHP 5)
	insinto ${PHPEXTDIR}
	einfo "Installing JAR for PHP"
	doins ext/java/php_java.jar

	einfo "Installing Java test page"
	newins ext/java/except.php java-test.php

	JAVA_LIBRARY="`grep -- '-DJAVALIB' Makefile | sed -e 's,.\+-DJAVALIB=\"\([^"]*\)\".*$,\1,g;'| sort | uniq `"
	sed -e "s|;java.library .*$|java.library = ${JAVA_LIBRARY}|g" -i ${phpinisrc}
	sed -e "s|;java.class.path .*$|java.class.path = ${PHPEXTDIR}/php_java.jar|g" -i ${phpinisrc}
	sed -e "s|;java.library.path .*$|java.library.path = ${PHPEXTDIR}|g" -i ${phpinisrc}
	sed -e "s|;extension=php_java.dll.*$|extension = java.so|g" -i ${phpinisrc}

	einfo "Installing Java extension for PHP"
	doins modules/java.so

	dosym ${PHPEXTDIR}/java.so ${PHPEXTDIR}/libphp_java.so
}

# ########################################################################
# MTA SUPPORT
# ########################################################################

php_check_mta() {
	[ -x "${ROOT}/usr/sbin/sendmail" ] || die "You need a virtual/mta that provides /usr/sbin/sendmail!"
}

# ########################################################################
# ORACLE SUPPORT
# ########################################################################

php_check_oracle() {
	if useq oci8 && [ -z "${ORACLE_HOME}" ]; then
		eerror
		eerror "You must have the ORACLE_HOME variable in your environment!"
		eerror
		die "Oracle configuration incorrect; user error"
	fi

	if useq oci8 || useq oracle7 ; then
		if has_version 'dev-db/oracle-instantclient-basic' ; then
			ewarn "Please ensure you have a full install of the Oracle client."
			ewarn "dev-db/oracle-instantclient* is NOT sufficient."
		fi
	fi
}

# ########################################################################
# END OF ECLASS
# ########################################################################
