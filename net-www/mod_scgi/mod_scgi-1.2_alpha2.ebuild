# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_scgi/mod_scgi-1.2_alpha2.ebuild,v 1.5 2004/08/30 23:31:35 dholm Exp $

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

MY_PN=${PN/mod_}
MY_PV=${PV/_alpha/a}
MY_P=${MY_PN}-${MY_PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Apache module for a Replacement for the CGI protocol that is similar to FastCGI"
URI_BASE="http://www.mems-exchange.org/software"
HOMEPAGE="${URI_BASE}/scgi/"
SRC_URI="${URI_BASE}/files/${MY_PN}/${MY_P}.tar.gz"
LICENSE="CNRI"
KEYWORDS="~x86 ~ppc"
IUSE="apache2"
DEPEND="${DEPEND}
		www-apps/scgi
		net-www/apache
		apache2? ( >=net-www/apache-2 )"

src_unpack() {
	unpack ${A}
	einfo "Fixing module name"
	for f in ${S}/apache[12]/Makefile; do
		sed -e 's/\(apxs[2]*\)/\1 -n mod_scgi/g' -i ${f}
	done
	for f in ${S}/apache[12]/mod_scgi.c; do
		sed -e 's/scgi_module/mod_scgi/g' -i ${f}
	done
}

src_compile() {
	detectapache true
	cd apache${APACHEVER}
	make || die "apache${APACHEVER} mod_scgi make failed"
}

src_install() {
	detectapache
	newdoc apache1/README README.apache1
	newdoc apache2/README README.apache2
	dodoc README PKG-INFO LICENSE.txt CHANGES
	exeinto /usr/lib/apache${APACHEVER}-extramodules
	doexe apache${APACHEVER}/.libs/${PN}.so
	insinto /etc/apache${APACHEVER}/conf/modules.d
	doins ${FILESDIR}/20_mod_scgi.conf
}

pkg_postinst() {
	detectapache
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D SCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D SCGI\" to APACHE_OPTS"
	fi
}

pkg_config() {
	detectapache
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D SCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_scgi.so mod_scgi.c scgi_module \
		before=perl define=SCGI addconf=conf/modules.d/20_mod_scgi.conf
		:;
	fi
}
