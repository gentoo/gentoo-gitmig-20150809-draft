# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_pcgi2/mod_pcgi2-2.0.1.ebuild,v 1.5 2004/04/05 00:43:19 zul Exp $

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
		if [ "`use apache2`" ]; then
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

DESCRIPTION="An Apache module to talk to Zope Corporation's PCGI"
HOMEPAGE="http://www.zope.org/Members/phd/${PN}/"
SRC_URI="http://zope.org/Members/phd/${PN}/${PV}/${P}-src.tar.gz"
LICENSE="GPL-2"
SLOT="${APACHEVER}"
KEYWORDS="~x86"
IUSE="apache2"

DEPEND="${DEPEND}
		net-www/apache
		apache2? ( >=net-www/apache-2 )
		net-www/pcgi"
#RDEPEND=""
S=${WORKDIR}/${PN/mod_}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-2.0.1-macrofix.patch
}

src_compile() {
	detectapache true
	if [ -n "${USE_APACHE2}" ]; then
		apxs2 \
		-n pcgi2  \
		-DUNIX -DAPACHE2 -DMOD_PCGI2 \
		-c mod_pcgi2.c pcgi-wrapper.c parseinfo.c \
		|| die "axps2 failed!"
		#-o mod_pcgi2.so \
	else
		apxs \
		-Wc,-DMOD_PCGI2 \
		-Wc,-DUNIX  \
		-Wc,-DHAVE_UNION_SEMUN  \
		-I./  \
		-o mod_pcgi2.so \
		-c mod_pcgi2.c parseinfo.c pcgi-wrapper.c \
		|| die "axps failed!"
	fi
}

src_install() {
	detectapache
	dodoc NEWS README TODO ChangeLog
	exeinto /usr/lib/apache${apache}-extramodules
	doexe .libs/${PN}.so
	insinto /etc/apache${apache}/conf/modules.d
	doins ${FILESDIR}/20_mod_pcgi.conf
}

pkg_postinst() {
	detectapache
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D PCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		einfo "1. Execute the command:"
		einfo " \"ebuild /var/db/pkg/${CATEGORY}/${PF}/${PF}.ebuild config\""
		einfo "2. Edit /etc/conf.d/apache and add \"-D PCGI\" to APACHE_OPTS"
	fi
}

pkg_config() {
	detectapache
	if [ -n "${USE_APACHE2}" ] ; then
		einfo "Add '-D PCGI' to your APACHE2_OPTS in /etc/conf.d/apache2"
	else
		${ROOT}/usr/sbin/apacheaddmod \
		${ROOT}/etc/apache/conf/apache.conf \
		extramodules/mod_pcgi2.so mod_pcgi2.c pcgi_module \
		before=perl define=pcgi addconf=conf/modules.d/20_mod_pcgi.conf
		:;
	fi
}
