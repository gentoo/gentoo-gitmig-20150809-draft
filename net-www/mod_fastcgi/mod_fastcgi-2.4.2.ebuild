# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_fastcgi/mod_fastcgi-2.4.2.ebuild,v 1.7 2004/09/03 16:49:02 pvdabeel Exp $

DESCRIPTION="FastCGI  is a language independent, scalable, open extension to CGI that provides high performance without the limitations of server specific APIs."
KEYWORDS="x86 ppc"
IUSE="apache2"

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

HOMEPAGE="http://fastcgi.com/"
SRC_URI="http://fastcgi.com/dist/${P}.tar.gz"
LICENSE="Apache-1.1"
DEPEND="net-www/apache
		apache2? ( >=net-www/apache-2 )"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	cd ${S}
	if [ "${APACHEVER}" -eq '2' ]; then
		cp ${FILESDIR}/Makefile-2.4.0 Makefile
	fi
}

src_compile() {
	if [ "${APACHEVER}" -eq '2' ]; then
		make || die "apache2 mod_scgi make failed"
	else
		/usr/sbin/apxs -o mod_fastcgi.so -c *.c || die "apache mod_scgi make failed"
	fi
}

src_install() {
	dodoc CHANGES README docs/LICENSE.TERMS docs/mod_fastcgi.html
	if [ "${APACHEVER}" -eq '2' ]; then
		exeinto /usr/lib/apache2-extramodules
		doexe .libs/${PN}.so
		insinto /etc/apache2/conf/modules.d
		doins ${FILESDIR}/20_mod_fastcgi.conf
	else
		exeinto /usr/lib/apache-extramodules
		doexe .libs/${PN}.so
		insinto /etc/apache/conf/addon-modules
		doins ${FILESDIR}/mod_fastcgi.conf
	fi
}

pkg_postinst() {
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D FASTCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/net-www/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D FASTCGI\" to APACHE_OPTS"
	fi
}

pkg_config() {
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D FASTCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		${ROOT}/usr/sbin/apacheaddmod \
			${ROOT}/etc/apache/conf/apache.conf \
			extramodules/mod_fastcgi.so mod_fastcgi.c fastcgi_module \
			before=perl define=FASTCGI addconf=conf/addon-modules/mod_fastcgi.conf
			:;
	fi
}

