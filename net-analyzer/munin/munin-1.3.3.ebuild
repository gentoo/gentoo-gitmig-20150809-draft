# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-1.3.3.ebuild,v 1.3 2007/05/13 06:09:08 robbat2 Exp $

inherit eutils

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin.sourceforge.net"
SRC_URI="mirror://sourceforge/munin/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc minimal munin-irc munin-dhcp munin-surfboard munin-apache munin-squid ssl"

# Upstream's listing of required modules is NOT correct!
DEPEND_COM="dev-lang/perl
			dev-perl/net-server
			sys-process/procps
			ssl? ( dev-perl/Net-SSLeay )
			dev-perl/Net-SNMP
			dev-perl/DateManip
			virtual/perl-Time-HiRes
			virtual/perl-Digest-MD5
			virtual/perl-Getopt-Long
			virtual/perl-Storable
			virtual/perl-Text-Balanced
			!minimal? ( dev-perl/HTML-Template
						net-analyzer/rrdtool )
			munin-irc? ( dev-perl/Net-IRC )
			munin-dhcp? ( dev-perl/Net-Netmask dev-perl/libwww-perl )
			munin-surfboard? ( dev-perl/libwww-perl )
			munin-apache? ( dev-perl/libwww-perl )
			munin-squid? ( virtual/perl-MIME-Base64 )"
			# Sybase isn't supported in Gentoo
			#munin-sybase? (	 dev-perl/DBD-Sybase )

# Keep this seperate, as previous versions have had other deps here
DEPEND="${DEPEND_COM}"
RDEPEND="${DEPEND_COM}
		virtual/cron"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
}

src_unpack() {
	if use !minimal; then
		if ! built_with_use net-analyzer/rrdtool perl ; then
			die 'Sorry, munin needs net-analyzer/rrdtool built with USE=perl.'
		fi
	fi
	unpack ${A}
	# upstream needs a lot of DESTDIR loving
	# and Gentoo location support
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.3.3-Makefile.patch
	# Fix noise in the plugins
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.3.2-plugin-cleanup.patch

	# Merged by upstream
	## Make it work with new versions of Rrdtool where : in COMMENT blocks must
	## be escaped!
	##EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${PN}-1.3.2-rrdtool-comments.patch
}

src_compile() {
	emake build build-man || die "build/build-man failed"
	if use doc; then
		emake build-doc || die "build-doc failed"
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

	emake DESTDIR="${D}" install-man || die "install manpages failed"

	insinto /etc/munin/plugin-conf.d/
	newins ${FILESDIR}/${PN}-1.3.2-plugins.conf munin-node

	# ensure TLS is disabled if built without SSL
	use ssl || echo "tls disabled" >>${D}/etc/munin/munin-node.conf

	# make sure we've got everything in the correct directory
	insinto /var/lib/munin
	newins ${FILESDIR}/${P}-crontab crontab
	newinitd ${FILESDIR}/munin-init.d munin-node
	dodoc README ChangeLog INSTALL logo.eps logo.svg build/resources/apache*
}

pkg_config() {
	einfo "Press enter to install the default crontab for the munin master"
	einfo "installation from /var/lib/munin/crontab"
	einfo "If you have a large site, you may wish to customize it."
	read
	crontab -u munin /var/lib/munin/crontab
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
