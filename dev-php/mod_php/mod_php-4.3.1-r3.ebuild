# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/mod_php/mod_php-4.3.1-r3.ebuild,v 1.3 2003/04/24 13:35:10 coredumb Exp $

inherit php eutils

IUSE="${IUSE} apache2"

DESCRIPTION="Apache module for PHP"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~hppa"
SLOT="0"

	# users have been having problems with compiling the gmp support... disabled for now
	# - rphillips
	#>=dev-libs/gmp-3.1.1

DEPEND="${DEPEND}
	|| (
		apache2? ( >=net-www/apache-2.0.43-r1 )
		>=net-www/apache-1.3.26-r2
	)
	"

RDEPEND="${RDEPEND}"

src_compile() {
	#no readline on server SAPI
	myconf="${myconf} --without-readline "

	# optional support for apache2
	myconf="${myconf} --with-exec-dir=/usr/bin"
	if [ "`use apache2`" ] ; then
		myconf="${myconf} --with-apxs2=/usr/sbin/apxs2"
	else
		myconf="${myconf} --with-apxs=/usr/sbin/apxs"
	fi

	#this is an extra item required with mcrypt (which is include in the eclass) when used with apache
	use crypt && myconf="${myconf} --disable-posix-threads"

	#php CGI stuff
	#--enable-discard-path --enable-force-cgi-redirect

	php_src_compile
}

 
src_install() {
	php_src_install

	cp php.ini-dist php.ini
	insinto /etc/php4
	doins php.ini
	dosym /usr/lib/apache-extramodules /etc/php4/lib

	if [ "`use apache2`" ] ; then
		exeinto /usr/lib/apache2-extramodules
		doexe .libs/libphp4.so
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/70_mod_php.conf
		dosym /etc/php4/php.ini /etc/apache2/conf/php.ini
	else
		exeinto /usr/lib/apache-extramodules
		doexe .libs/libphp4.so
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_php.conf
		dosym /etc/php4/php.ini /etc/apache/conf/php.ini
		dosym /etc/php4/php.ini /etc/apache/conf/addon-modules/php.ini
	fi
}

pkg_postinst() {
	einfo
	einfo "To have Apache run php programs, please do the following:"
	if [ "`use apache2`" ] ; then
		einfo "Edit /etc/conf.d/apache2 and add \"-D PHP4\""
		einfo
		einfo "Please note Apache 2 support in php is currently experimental"
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/dev-php/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D PHP4\""
		einfo
		einfo "That will include the php mime types in your configuration"
		einfo "automagically and setup Apache to load php when it starts."
	fi
}

pkg_config() {
	${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/libphp4.so mod_php4.c php4_module \
		before=perl define=PHP4 addconf=conf/addon-modules/mod_php.conf
	:;
}
