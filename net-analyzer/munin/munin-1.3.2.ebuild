# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-1.3.2.ebuild,v 1.2 2006/10/19 09:48:27 robbat2 Exp $

inherit eutils

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin.sourceforge.net"
SRC_URI="mirror://sourceforge/munin/${PN}_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="doc munin-irc munin-dhcp munin-surfboard munin-apache munin-squid"

# Upstream's listing of required modules is NOT correct!
DEPEND_COM="dev-lang/perl
			net-analyzer/rrdtool
			dev-perl/net-server
			sys-process/procps
			dev-perl/Net-SSLeay
			dev-perl/Net-SNMP
			dev-perl/DateManip
			virtual/perl-Time-HiRes
			virtual/perl-Digest-MD5
			virtual/perl-Getopt-Long
			virtual/perl-MIME-Base64
			virtual/perl-Storable
			virtual/perl-Text-Balanced
			dev-perl/HTML-Template
			munin-irc? ( dev-perl/Net-IRC )
			munin-dhcp? ( dev-perl/Net-Netmask dev-perl/libwww-perl )
			munin-surfboard? ( dev-perl/libwww-perl )
			munin-apache? ( dev-perl/libwww-perl )
			munin-squid? ( virtual/perl-MIME-Base64 )"
			# Sybase isn't supported in Gentoo
			#munin-sybase? (	 dev-perl/DBD-Sybase )

DEPEND="${DEPEND_COM}
		doc? ( app-text/htmldoc
			   app-text/html2text )"
RDEPEND="${DEPEND_COM}
		virtual/cron"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
}

src_unpack() {
	unpack ${A}
	# upstream needs a lot of DESTDIR loving
	# and Gentoo location support
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-Makefile.patch
	# Fix noise in the plugins
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-plugin-cleanup.patch
	# Make it work with new versions of Rrdtool where : in COMMENT blocks must
	# be escaped!
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-rrdtool-comments.patch
}

src_compile() {
	emake build build-man || die "build/build-man failed"
	if use doc; then
		emake build-doc || die "build-doc failed"
	fi
}

src_install() {
	local dirs
	dirs="/var/log/munin /var/lib/munin"
	dirs="${dirs} /var/lib/munin/plugin-state"
	dirs="${dirs} /var/run/munin/plugin-state"
	keepdir ${dirs}

	emake DESTDIR="${D}" install-main install-man install-node install-node-plugins || die "install failed"
	fowners munin:munin ${dirs}

	if use doc; then
		emake DESTDIR="${D}" install-doc install-man || die "install docs failed"
	fi

	insinto /etc/munin/plugin-conf.d/
	newins ${FILESDIR}/${P}-plugins.conf munin-node

	# make sure we've got everything in the correct directory
	insinto /var/lib/munin
	newins ${FILESDIR}/${P}-crontab crontab
	newinitd ${FILESDIR}/munin-init.d munin-node
	dodoc ChangeLog INSTALL README-apache-cgi.in README.api logo.eps
	munin-doc-base.html munin-faq-base.html TODO.plugins
	newdoc server/TODO TODO.server
	newdoc node/TODO TODO.node
}

pkg_config() {
	crontab -l -u munin 2>/dev/null | grep --silent '.*'
	if [ $? -eq 0 ]; then
		die "Crontab already install for user munin. Not overwriting."
	fi
	einfo "Press enter to install the default crontab for the munin master"
	einfo "installation from /var/lib/munin/crontab"
	einfo "If you have a large site, you may wish to customize it."
	read
	crontab -u munin /var/lib/munin/crontab
}

pkg_postinst() {
	einfo "Please start munin-node via /etc/init.d/munin-node."
	einfo "To have munin's cronjob automatically configured for you if this is"
	einfo "your munin master installation, please:"
	einfo "emerge --config net-analyzer/munin"
}
