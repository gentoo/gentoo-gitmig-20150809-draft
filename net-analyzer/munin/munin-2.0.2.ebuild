# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-2.0.2.ebuild,v 1.1 2012/07/16 16:15:11 flameeyes Exp $

EAPI=4

inherit eutils user versionator

MY_P=${P/_/-}

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin-monitoring.org/"
SRC_URI="mirror://sourceforge/munin/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE="asterisk doc irc java memcached minimal mysql postgres ssl test cgi"

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
			cgi? ( dev-perl/FCGI )
			dev-perl/DateManip
			dev-perl/File-Copy-Recursive
			dev-perl/IO-Socket-INET6
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

# Keep this seperate, as previous versions have had other deps here
DEPEND="${DEPEND_COM}
	virtual/perl-Module-Build
	test? (
		dev-perl/Test-LongString
		dev-perl/Test-Differences
		dev-perl/Test-MockModule
		dev-perl/File-Slurp
		dev-perl/IO-stringy
	)"
RDEPEND="${DEPEND_COM}
		!minimal? ( virtual/cron )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.4.7-munin-version-identifier.patch

	# Don't build java plugins if not requested via USE.
	if ! use java; then
		sed -i -e 's: build-plugins-java : :' \
			-e 's: install-plugins-java : :' Makefile || die
	fi

	# Bug 304447, fix for gentoo PS location
	sed -i -e 's,/usr/bin/ps,/bin/ps,g' \
		"${S}"/plugins/node.d/ifx_concurrent_sessions_.in || die

	# bug 367785, cleanup make output by disabling HP-UX cruft
	sed -i "/plugins\/\*\.adv/d" Makefile || die
}

src_configure() {
	local cgidir='$(DESTDIR)/var/www/localhost/cgi-bin'
	use cgi || cgidir="${T}/useless/cgi-bin"

	cat - >> "${S}"/Makefile.config <<EOF
PREFIX=\$(DESTDIR)/usr
CONFDIR=\$(DESTDIR)/etc/munin
DOCDIR=\$(DESTDIR)/usr/share/doc/${PF}
MANDIR=\$(PREFIX)/share/man
LIBDIR=\$(PREFIX)/libexec/munin
HTMLDIR=\$(DESTDIR)/var/www/localhost/htdocs/munin
CGIDIR=${cgidir}
DBDIR=\$(DESTDIR)/var/lib/munin
LOGDIR=\$(DESTDIR)/var/log/munin
PERLSITELIB=$(perl -V:vendorlib | cut -d"'" -f2)
EOF
}

src_compile() {
	emake default $(use doc && echo build-doc)
}

src_install() {
	local dirs
	dirs="/var/log/munin/ /var/lib/munin/"
	dirs="${dirs} /var/lib/munin/plugin-state/"
	dirs="${dirs} /etc/munin/plugin-conf.d/"
	dirs="${dirs} /etc/munin/munin-conf.d/"
	dirs="${dirs} /etc/munin/plugins/"
	keepdir ${dirs}

	local install_targets="install-common-prime install-node-prime install-plugins-prime"
	use minimal || install_targets=install

	emake DESTDIR="${D}" ${install_targets}
	fowners munin:munin ${dirs}

	insinto /etc/munin/plugin-conf.d/
	newins "${FILESDIR}"/${PN}-1.3.2-plugins.conf munin-node

	# make sure we've got everything in the correct directory
	insinto /var/lib/munin
	newins "${FILESDIR}"/${PN}-2.0_rc-crontab crontab
	newinitd "${FILESDIR}"/munin-node_init.d_2.0.2 munin-node
	newconfd "${FILESDIR}"/munin-node_conf.d_1.4.6-r2 munin-node
	dodoc README ChangeLog INSTALL build/resources/apache*

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
	elog
	if ! use minimal; then
		elog "To have munin's cronjob automatically configured for you if this is"
		elog "your munin master installation, please:"
		elog "emerge --config net-analyzer/munin"
	fi
}
