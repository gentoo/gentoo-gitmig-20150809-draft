# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-1.4.7-r2.ebuild,v 1.2 2012/07/25 06:56:53 mr_bones_ Exp $

EAPI=4

PATCHSET=1

inherit eutils user

MY_P=${P/_/-}

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin-monitoring.org/"
SRC_URI="mirror://sourceforge/munin/${MY_P}.tar.gz
	http://dev.gentoo.org/~flameeyes/${PN}/${P}-patches-${PATCHSET}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE="asterisk doc irc memcached minimal mysql postgres ssl"

# Upstream's listing of required modules is NOT correct!
# Some of the postgres plugins use DBD::Pg, while others call psql directly.
# Some of the mysql plugins use DBD::mysql, while others call mysqladmin directly.
DEPEND_COM="dev-lang/perl
			sys-process/procps
			asterisk? ( dev-perl/Net-Telnet )
			irc? ( dev-perl/Net-IRC )
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
	epatch "${WORKDIR}"/patches/*.patch

	# Don't build java plugins in this series
	# sed is needed so the java plugins aren't automagically built.
	sed -i -e 's: build-plugins-java : :' \
		-e 's: install-plugins-java : :' Makefile || die
}

src_compile() {
	emake -j 1 build build-man
	if use doc; then
		emake -j 1 build-doc
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
			install-plugins-prime
	else
		emake -j 1 DESTDIR="${D}" install
	fi
	fowners munin:munin ${dirs}

	insinto /etc/munin/plugin-conf.d/
	newins "${FILESDIR}"/${PN}-1.3.2-plugins.conf munin-node

	newinitd "${FILESDIR}"/munin-node_init.d_2.0.2 munin-node
	newconfd "${FILESDIR}"/munin-node_conf.d_1.4.6-r2 munin-node
	dodoc README ChangeLog INSTALL logo.eps logo.svg build/resources/apache*

	# bug 254968
	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/logrotate.d-munin munin

	if ! use minimal; then
		exeinto /etc/local.d/
		newexe "${FILESDIR}"/localstart-munin 50munin.start

		dodir /usr/share/${PN}
		cat - >> "${D}"/usr/share/${PN}/crontab <<EOF
# Force the shell to bash
SHELL=/bin/bash
# Mail reports to root@, not munin@
MAILTO=root

# This runs the munin task every 5 minutes.
*/5	* * * *		/usr/bin/munin-cron

# Alternatively, this route works differently
# Update once a minute (for busy sites)
#*/1 * * * *		/usr/libexec/munin/munin-update
## Check for limit excess every 2 minutes
#*/2 * * * *		/usr/libexec/munin/munin-limits
## Update graphs every 5 minutes
#*/5 * * * *		nice /usr/libexec/munin/munin-graph
## Update HTML pages every 15 minutes
#*/15 * * * *		nice /usr/libexec/munin/munin-html
EOF

		cat - >> "${D}"/usr/share/${PN}/fcrontab <<EOF
# Mail reports to root@, not munin@, only execute one at a time
!mailto(root),serial(true)

# This runs the munin task every 5 minutes.
@ 5		/usr/bin/munin-cron

# Alternatively, this route works differently
# Update once a minute (for busy sites)
#@ 1	/usr/libexec/munin/munin-update
## Check for limit excess every 2 minutes
#@ 2	/usr/libexec/munin/munin-limits
## Update graphs every 5 minutes
#@ 5	nice /usr/libexec/munin/munin-graph
## Update HTML pages every 15 minutes
#@ 15	nice /usr/libexec/munin/munin-html
EOF
	fi
}

pkg_config() {
	if use minimal; then
		einfo "Nothing to do."
		return 0
	fi

	einfo "Press enter to install the default crontab for the munin master"
	einfo "installation from /usr/share/${PN}/f?crontab"
	einfo "If you have a large site, you may wish to customize it."
	read

	if has_version sys-process/fcron; then
		fcrontab - -u munin < /usr/share/${PN}/fcrontab
	else
		# dcron is very fussy about syntax
		# the following is the only form that works in BOTH dcron and vixie-cron
		crontab - -u munin < /usr/share/${PN}/crontab
	fi
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
