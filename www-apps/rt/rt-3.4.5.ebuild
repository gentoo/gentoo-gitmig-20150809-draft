# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/rt/rt-3.4.5.ebuild,v 1.7 2006/04/24 15:55:32 rl03 Exp $

inherit webapp eutils

IUSE="mysql postgres fastcgi apache2 lighttpd"

DESCRIPTION="RT is an enterprise-grade ticketing system"
HOMEPAGE="http://www.bestpractical.com/rt/"
SRC_URI="http://download.bestpractical.com/pub/${PN}/release/${P}.tar.gz"

KEYWORDS="~ppc ~x86"

DEPEND="
	>=dev-lang/perl-5.8.3

	>=dev-perl/Params-Validate-0.02
	dev-perl/Cache-Cache
	>=dev-perl/Exception-Class-1.14
	>dev-perl/HTML-Mason-1.23
	dev-perl/MLDBM
	dev-perl/FreezeThaw
	>=virtual/perl-Digest-MD5-2.27
	>=virtual/perl-CGI-2.92
	>=virtual/perl-Storable-2.08
	>=dev-perl/Apache-Session-1.53
	>=dev-perl/XML-RSS-1.05
	>=dev-perl/HTTP-Server-Simple-0.07
	>=dev-perl/HTTP-Server-Simple-Mason-0.09
	dev-perl/Text-WikiFormat

	!lighttpd? (
		>=dev-perl/Apache-DBI-0.92
		apache2? (
			!fastcgi? ( >=www-apache/libapreq2-2.06
						>=dev-perl/HTML-Mason-1.31 ) )
			fastcgi? ( dev-perl/FCGI )
		!apache2? (
			fastcgi? ( dev-perl/FCGI )
			!fastcgi? ( =www-apache/libapreq-1* ) ) )
	lighttpd? ( dev-perl/FCGI )

	mysql? ( >=dev-perl/DBD-mysql-2.1018 )
	postgres? ( >=dev-perl/DBD-Pg-1.41 )

	>=virtual/perl-Getopt-Long-2.24

	dev-perl/HTML-Tree
	dev-perl/HTML-Format
	dev-perl/libwww-perl

	virtual/perl-digest-base
	>=dev-perl/DBI-1.37
	dev-perl/Test-Inline
	>=dev-perl/class-returnvalue-0.40
	>=dev-perl/dbix-searchbuilder-1.35
	dev-perl/text-template
	>=virtual/perl-File-Spec-0.8
	dev-perl/HTML-Parser
	>=dev-perl/HTML-Scrubber-0.08
	virtual/perl-libnet
	>=dev-perl/log-dispatch-2.0
	>=dev-perl/locale-maketext-lexicon-0.32
	dev-perl/locale-maketext-fuzzy
	>=dev-perl/MIME-tools-5.417
	>=dev-perl/MailTools-1.60
	dev-perl/text-wrapper
	dev-perl/Time-modules
	virtual/perl-File-Temp
	dev-perl/TermReadKey
	dev-perl/text-autoformat
	>=dev-perl/Text-Quoted-1.3
	>=dev-perl/Tree-Simple-1.04
	virtual/perl-Scalar-List-Utils
	dev-perl/Module-Versions-Report
	dev-perl/Cache-Simple-TimedExpiry
	dev-perl/XML-Simple
	dev-perl/regexp-common
"

RDEPEND="
	${DEPEND}
	virtual/mta
	mysql? ( >=dev-db/mysql-4.0.13 )
	postgres? ( >=dev-db/postgresql-7.4.2-r1 )
	!lighttpd? (
		apache2? ( >=net-www/apache-2
			fastcgi? ( net-www/mod_fastcgi )
		!apache2? ( =net-www/apache-1* ) ) )
	lighttpd? ( >=www-servers/lighttpd-1.3.13 )
"

LICENSE="GPL-2"

add_user_rt() {
	# add new user
	# suexec2 requires uid >= 1000; enewuser is of no help here
	# From: Mike Frysinger <vapier@gentoo.org>
	# Date: Fri, 17 Jun 2005 08:41:44 -0400
	# i'd pick a 5 digit # if i were you

	local euser="rt"

	# first check if username rt exists
	if [[ ${euser} == $(egetent passwd "${euser}" | cut -d: -f1) ]] ; then
		# check uid
		rt_uid=$(egetent passwd "${euser}" | cut -d: -f3)
		if $(expr ${rt_uid} '<' 1000 > /dev/null); then
			ewarn "uid of user rt is less than 1000. suexec2 will not work."
			ewarn "If you want to use FastCGI, please delete the user 'rt'"
			ewarn "from your system and re-emerge www-apps/rt"
			epause
		fi
		return 0 # all is well
	fi

	# add user
	# stolen from enewuser
	local pwrange euid

	pwrange=$(seq 10001 11001)
	for euid in ${pwrange} ; do
		[[ -z $(egetent passwd ${euid}) ]] && break
	done
	if [[ ${euid} == "11001" ]]; then
		# she gets around, doesn't she?
		die "No available uid's found"
	fi

	einfo " - Userid: ${euid}"

	enewuser rt ${euid} -1 /dev/null rt > /dev/null
	return 0
}

pkg_setup() {
	webapp_pkg_setup

	use mysql && ewarn "RT needs MySQL with innodb support"
	ewarn
	ewarn "If you are upgrading from an existing _RT2_ installation,"
	ewarn "stop this ebuild (Ctrl-C now), download the upgrade tool,"
	ewarn "http://bestpractical.com/pub/rt/devel/rt2-to-rt3.tar.gz"
	ewarn "and follow the included instructions."
	ewarn
	epause 5
	enewgroup rt >/dev/null
	add_user_rt || die "Could not add user"

}

src_unpack() {
	unpack ${A}
	cd ${S}

	# add Gentoo-specific layout
	cat ${FILESDIR}/config.layout-gentoo >> config.layout
	sed -e "s|PREFIX|${D}/${MY_HOSTROOTDIR}/${PF}|
			s|HTMLDIR|${D}/${MY_HTDOCSDIR}|g" -i ./config.layout || die

	# don't need to check dev dependencies
	sed -e "s|\$args{'with-DEV'} =1;|#\$args{'with-DEV'} =1;|" -i sbin/rt-test-dependencies.in || die
}

src_compile() {

	local web="apache"
	if useq lighttpd; then
		web="lighttpd"
	fi

	./configure --enable-layout=Gentoo \
		--with-bin-owner=rt \
		--with-libs-owner=rt \
		--with-libs-group=rt \
		--with-rt-group=rt \
		--with-web-user=${web} \
		--with-web-group=${web}

	# check for missing deps and ask to report if something is broken
	local myconf="--verbose $(use_with mysql) \
		$(use_with postgres pg) \
		$(use_with fastcgi) \
		$(use_with lighttpd fastcgi)"
	if ! useq fastcgi && ! useq lighttpd; then
		myconf="${myconf} $(use_with apache2 modperl2)"
		! useq apache2 && myconf="${myconf} --with-modperl1"
	fi

	/usr/bin/perl ./sbin/rt-test-dependencies ${myconf} > ${T}/t
	if grep -q "MISSING" ${T}/t; then
		ewarn "Missing Perl dependency!"
		ewarn
		cat ${T}/t
		ewarn
		ewarn "Please file a bug in the Gentoo Bugzilla with the information above"
		ewarn "and assign it to rl03@gentoo.org"
		die "Missing dependencies."
	fi
}

src_install() {
	webapp_src_preinst

	make install

	# make sure we don't clobber existing site configuration
	rm -f ${D}/${MY_HOSTROOTDIR}/${PF}/etc/RT_SiteConfig.pm

	# copy upgrade files
	cp -R etc/upgrade ${D}/${MY_HOSTROOTDIR}/${PF}

	cd ${D}
	grep -Rl "${D}" * | xargs dosed

	if useq lighttpd; then
		newinitd ${FILESDIR}/${PN}.init.d ${PN}
		newconfd ${FILESDIR}/${PN}.conf.d ${PN}
	else
		if useq apache2; then
			local CONF="rt_apache2_fcgi.conf rt_apache2.conf"
		else
			local CONF="rt_apache1_fcgi.conf rt_apache.conf"
		fi
		cd ${FILESDIR} && cp ${CONF} ${D}/${MY_HOSTROOTDIR}/${PF}/etc
	fi
	webapp_postinst_txt en ${FILESDIR}/${PV}/postinstall-en.txt
	webapp_hook_script ${FILESDIR}/${PV}/reconfig
	webapp_src_install
}
