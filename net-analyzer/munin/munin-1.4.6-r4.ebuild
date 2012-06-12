# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-1.4.6-r4.ebuild,v 1.5 2012/06/12 02:29:18 zmedico Exp $

EAPI=2

inherit eutils user

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin.projects.linpro.no/"
SRC_URI="mirror://sourceforge/munin/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc x86"
IUSE="asterisk doc irc java memcached minimal mysql postgres ssl"

# Upstream's listing of required modules is NOT correct!
# Some of the postgres plugins use DBD::Pg, while others call psql directly.
# Some of the mysql plugins use DBD::mysql, while others call mysqladmin directly.
DEPEND_COM="dev-lang/perl
			sys-process/procps
			asterisk? ( dev-perl/Net-Telnet )
			irc? ( dev-perl/Net-IRC )
			java? ( >=virtual/jdk-1.5 )
			mysql? ( virtual/mysql
					 dev-perl/Cache-Cache
					 dev-perl/DBD-mysql )
			ssl? ( dev-perl/Net-SSLeay )
			postgres? ( dev-perl/DBD-Pg dev-db/postgresql-base )
			memcached? ( dev-perl/Cache-Memcached )
			dev-perl/DateManip
			dev-perl/Net-CIDR
			dev-perl/Net-Netmask
			dev-perl/Net-SNMP
			dev-perl/libwww-perl
			dev-perl/net-server
			dev-perl/DBI
			virtual/perl-Digest-MD5
			virtual/perl-Getopt-Long
			virtual/perl-MIME-Base64
			virtual/perl-Storable
			virtual/perl-Text-Balanced
			virtual/perl-Time-HiRes
			!minimal? ( dev-perl/HTML-Template
						net-analyzer/rrdtool[perl]
						dev-perl/Log-Log4perl )"
			# Sybase isn't supported in Gentoo
			#munin-sybase? (	 dev-perl/DBD-Sybase )

# Keep this seperate, as previous versions have had other deps here
DEPEND="${DEPEND_COM}
	virtual/perl-Module-Build"
RDEPEND="${DEPEND_COM}
		!minimal? ( virtual/cron )"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
}

src_prepare() {
	# upstream needs a lot of DESTDIR loving
	# and Gentoo location support
	epatch "${FILESDIR}"/${PN}-1.4.4-Makefile.patch

	epatch "${FILESDIR}"/${PN}-1.4.6-apc-temp.patch
	epatch "${FILESDIR}"/${PN}-1.4.6-munin-version-identifier.patch
	epatch "${FILESDIR}"/${PN}-1.4.6-fix-asterisk-plugins.patch
	epatch "${FILESDIR}"/${PN}-1.4.6-if_-hardened.patch
	epatch "${FILESDIR}"/${PN}-1.4.6-apc-multi.patch

	# Don't build java plugins if not requested via USE.
	if ! use java; then
		# sed is needed so the java plugins aren't automagically built.
		sed -i -e 's: build-plugins-java : :' \
			-e 's: install-plugins-java : :' Makefile || die
	fi

	# Bug 304447, fix for gentoo PS location
	sed -i -e 's,/usr/bin/ps,/bin/ps,g' \
		"${S}"/plugins/node.d/ifx_concurrent_sessions_.in || die

	# bug 367785, cleanup make output by disabling HP-UX cruft
	sed -i -e "/plugins\/\*\.adv/d" Makefile || die
}

src_compile() {
	emake -j 1 build build-man || die "build/build-man failed"
	if use doc; then
		emake -j 1 build-doc || die "build-doc failed"
	fi

	#Ensure TLS is disabled if built without SSL
	if ! use ssl; then
		echo "tls disabled" >> ${S}/build/node/munin-node.conf \
			|| die "Fixing munin-node.conf Failed!"
		echo "tls disabled" >> ${S}/build/master/munin.conf \
			|| die "Fixing munin.conf Failed!"
	fi

}

src_install() {
	local dirs
	dirs="/var/log/munin/ /var/lib/munin/"
	dirs="${dirs} /var/lib/munin/plugin-state/"
	dirs="${dirs} /var/run/munin/plugin-state/"
	dirs="${dirs} /var/run/munin/spool/"
	dirs="${dirs} /etc/munin/plugin-conf.d/"
	dirs="${dirs} /etc/munin/munin-conf.d/"
	dirs="${dirs} /etc/munin/plugins/"
	keepdir ${dirs}

	if use minimal; then
		emake -j 1 DESTDIR="${D}" install-common-prime install-node-prime \
			install-plugins-prime || die "install failed"
	else
		emake -j 1 DESTDIR="${D}" install || die "install failed"
	fi
	fowners munin:munin ${dirs} || die

	insinto /etc/munin/plugin-conf.d/
	newins "${FILESDIR}"/${PN}-1.3.2-plugins.conf munin-node || die

	# make sure we've got everything in the correct directory
	insinto /var/lib/munin
	newins "${FILESDIR}"/${PN}-1.3.3-crontab crontab || die
	newinitd "${FILESDIR}"/munin-node_init.d_1.4.6-r2 munin-node || die
	newconfd "${FILESDIR}"/munin-node_conf.d_1.4.6-r2 munin-node || die
	dodoc README ChangeLog INSTALL logo.eps logo.svg build/resources/apache* \
		|| die

	# bug 254968
	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/logrotate.d-munin munin || die
}

pkg_config() {
	einfo "Press enter to install the default crontab for the munin master"
	einfo "installation from /var/lib/munin/crontab"
	einfo "If you have a large site, you may wish to customize it."
	read
	# dcron is very fussy about syntax
	# the following is the only form that works in BOTH dcron and vixie-cron
	crontab - -u munin </var/lib/munin/crontab
}

pkg_postinst() {
	elog "Please follow the munin documentation to set up the plugins you"
	elog "need, afterwards start munin-node via /etc/init.d/munin-node."
	if ! use minimal; then
		elog "To have munin's cronjob automatically configured for you if this is"
		elog "your munin master installation, please:"
		elog "emerge --config net-analyzer/munin"
	fi
}
