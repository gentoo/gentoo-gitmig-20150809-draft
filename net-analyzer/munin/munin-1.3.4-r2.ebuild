# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-1.3.4-r2.ebuild,v 1.9 2010/01/11 07:41:55 hollow Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin.sourceforge.net"
SRC_URI="mirror://sourceforge/munin/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE="doc minimal irc mysql postgres ssl"

# Upstream's listing of required modules is NOT correct!
# Some of the postgres plugins use DBD::Pg, while others call psql directly.
# The mysql plugins use mysqladmin directly.
DEPEND_COM="dev-lang/perl
			sys-process/procps
			ssl? ( dev-perl/Net-SSLeay )
			mysql? ( virtual/mysql )
			postgres? ( dev-perl/DBD-Pg virtual/postgresql-base )
			irc? ( dev-perl/Net-IRC )
			dev-perl/DateManip
			dev-perl/Net-CIDR
			dev-perl/Net-Netmask
			dev-perl/Net-SNMP
			dev-perl/libwww-perl
			dev-perl/net-server
			virtual/perl-Digest-MD5
			virtual/perl-Getopt-Long
			virtual/perl-MIME-Base64
			virtual/perl-Storable
			virtual/perl-Text-Balanced
			virtual/perl-Time-HiRes
			!minimal? ( dev-perl/HTML-Template
						net-analyzer/rrdtool[perl] )"
			# Sybase isn't supported in Gentoo
			#munin-sybase? (	 dev-perl/DBD-Sybase )

# Keep this seperate, as previous versions have had other deps here
DEPEND="${DEPEND_COM}"
RDEPEND="${DEPEND_COM}
		!minimal? ( virtual/cron )"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
}

src_prepare() {
	# upstream needs a lot of DESTDIR loving
	# and Gentoo location support
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.3.4-Makefile.patch
	# Fix noise in the plugins
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.3.4-plugin-cleanup.patch

	# Bug #195964, fix up conntrack
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.3-fw_conntrack_plugins.patch

	# Bug #225671, cannot produce HTML if RRD and graphs have not yet run.
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.4-no-html-if-no-input.patch

	# Bug #253965, compatibility changes for rrdtool 1.3
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.4-rrdtool-1.3.patch

	# Bug #248849, samba plugin does not have max values
	EPATCH_OPTS="-p0 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.4-samba-plugin.patch

	# Bug #267801, ensure that directories to install to are created before
	# trying to populate them for parallel install.
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.4-parallel-make-fix.patch

	# Bug #276637, make munin-graph be terser. No more debug output unless
	# --debug is on.
	EPATCH_OPTS="-p1 -d ${S}" epatch "${FILESDIR}"/${PN}-1.3.4-terser-munin-graph.patch
}

src_compile() {
	emake build build-man || die "build/build-man failed"
	if use doc; then
		emake build-doc || die "build-doc failed"
	fi

	#Ensure TLS is disabled if built without SSL
	if ! use ssl; then
		echo "tls disabled" >> ${S}/build/node/munin-node.conf \
			|| die "Fixing munin-node.conf Failed!"
		echo "tls disabled" >> ${S}/build/server/munin.conf \
			|| die "Fixing munin.conf Failed!"
	fi

}

src_install() {
	local dirs
	dirs="/var/log/munin/ /var/lib/munin/"
	dirs="${dirs} /var/lib/munin/plugin-state/"
	dirs="${dirs} /var/run/munin/plugin-state/"
	dirs="${dirs} /etc/munin/plugin-conf.d/"
	dirs="${dirs} /etc/munin/plugins/"
	keepdir ${dirs}

	emake DESTDIR="${D}" install-main install-man install-node install-node-plugins || die "install failed"
	fowners munin:munin ${dirs}

	insinto /etc/munin/plugin-conf.d/
	newins "${FILESDIR}"/${PN}-1.3.2-plugins.conf munin-node

	# make sure we've got everything in the correct directory
	insinto /var/lib/munin
	newins "${FILESDIR}"/${PN}-1.3.3-crontab crontab
	newinitd "${FILESDIR}"/munin-node_init.d_1.3.3-r1 munin-node
	newconfd "${FILESDIR}"/munin-node_conf.d_1.3.3-r1 munin-node
	dodoc README ChangeLog INSTALL logo.eps logo.svg build/resources/apache*

	# bug 254968
	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/logrotate.d-munin munin
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
	elog "To have munin's cronjob automatically configured for you if this is"
	elog "your munin master installation, please:"
	elog "emerge --config net-analyzer/munin"
	elog ""
	elog "Please note that the crontab has undergone some modifications"
	elog "since 1.3.2, and you should update to it!"
}
