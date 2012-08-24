# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/munin/munin-2.0.5-r2.ebuild,v 1.2 2012/08/24 22:13:22 flameeyes Exp $

EAPI=4

PATCHSET=3

inherit eutils user java-pkg-opt-2

MY_P=${P/_/-}

DESCRIPTION="Munin Server Monitoring Tool"
HOMEPAGE="http://munin-monitoring.org/"
SRC_URI="mirror://sourceforge/munin/${MY_P}.tar.gz
	http://dev.gentoo.org/~flameeyes/${PN}/${P}-patches-${PATCHSET}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
IUSE="asterisk irc java memcached minimal mysql postgres ssl test cgi ipv6 syslog ipmi http"
REQUIRED_USE="cgi? ( !minimal )"

# Upstream's listing of required modules is NOT correct!
# Some of the postgres plugins use DBD::Pg, while others call psql directly.
# Some of the mysql plugins use DBD::mysql, while others call mysqladmin directly.
# We replace the original ipmi plugins with the freeipmi_ plugin which at least works.
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
			cgi? ( dev-perl/FCGI )
			syslog? ( virtual/perl-Sys-Syslog )
			ipmi? (
				>=sys-libs/freeipmi-1.1.6-r1
				virtual/awk
			)
			http? ( dev-perl/libwww-perl )
			dev-perl/DBI
			dev-perl/DateManip
			dev-perl/File-Copy-Recursive
			dev-perl/Log-Log4perl
			dev-perl/Net-CIDR
			dev-perl/Net-Netmask
			dev-perl/Net-SNMP
			dev-perl/net-server[ipv6(-)?]
			virtual/perl-Digest-MD5
			virtual/perl-Getopt-Long
			virtual/perl-MIME-Base64
			virtual/perl-Storable
			virtual/perl-Text-Balanced
			virtual/perl-Time-HiRes
			!minimal? (
				dev-perl/HTML-Template
				dev-perl/IO-Socket-INET6
				>=net-analyzer/rrdtool-1.3[perl]
			)"

# Keep this seperate, as previous versions have had other deps here
DEPEND="${DEPEND_COM}
	virtual/perl-Module-Build
	java? ( >=virtual/jdk-1.5 )
	test? (
		dev-perl/Test-LongString
		dev-perl/Test-Differences
		dev-perl/Test-MockModule
		dev-perl/File-Slurp
		dev-perl/IO-stringy
		dev-perl/IO-Socket-INET6
	)"
RDEPEND="${DEPEND_COM}
		java? (
			>=virtual/jre-1.5
			|| ( net-analyzer/netcat6 net-analyzer/netcat )
		)
		!minimal? (
			virtual/cron
			media-fonts/dejavu
		)"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup munin
	enewuser munin 177 -1 /var/lib/munin munin
	enewuser munin-async -1 /bin/true /var/lib/munin-async
	java-pkg-opt-2_pkg_setup
}

src_prepare() {
	epatch "${WORKDIR}"/patches/*.patch

	java-pkg-opt-2_src_prepare
}

src_configure() {
	local cgidir='$(DESTDIR)/var/www/localhost/cgi-bin'
	use cgi || cgidir="${T}/useless/cgi-bin"

	cat - >> "${S}"/Makefile.config <<EOF
PREFIX=\$(DESTDIR)/usr
CONFDIR=\$(DESTDIR)/etc/munin
DOCDIR=${T}/useless/doc
MANDIR=\$(PREFIX)/share/man
LIBDIR=\$(PREFIX)/libexec/munin
HTMLDIR=\$(DESTDIR)/var/www/localhost/htdocs/munin
CGIDIR=${cgidir}
DBDIR=\$(DESTDIR)/var/lib/munin
SPOOLDIR=\$(DESTDIR)/var/spool/munin-async
LOGDIR=\$(DESTDIR)/var/log/munin
PERLSITELIB=$(perl -V:vendorlib | cut -d"'" -f2)
JCVALID=$(usex java yes no)
EOF
}

# parallel make and install need to be fixed before, and I haven't
# gotten around to do so yet.
src_compile() {
	emake -j1
}

src_install() {
	local dirs="
		/var/log/munin
		/var/lib/munin/plugin-state
		/etc/munin/plugin-conf.d
		/etc/munin/plugins"
	keepdir ${dirs}
	fowners munin:munin ${dirs}

	local install_targets="install-common-prime install-node-prime install-plugins-prime"
	use java && install_targets+=" install-plugins-java"

	use minimal || install_targets=install
	use minimal || dirs+=" /etc/munin/munin-conf.d/"

	# parallel install doesn't work and it's also pointless to have this
	# run in parallel for now (because it uses internal loops).
	emake -j1 DESTDIR="${D}" ${install_targets}

	# remove the plugins for non-Gentoo package managers
	rm "${D}"/usr/libexec/munin/plugins/{apt{,_all},yum} || die

	insinto /etc/munin/plugin-conf.d/
	newins "${FILESDIR}"/${PN}-1.3.2-plugins.conf munin-node

	newinitd "${FILESDIR}"/munin-node_init.d_2.0.5 munin-node
	newconfd "${FILESDIR}"/munin-node_conf.d_1.4.6-r2 munin-node

	newinitd "${FILESDIR}"/munin-asyncd.init.2 munin-asyncd

	dodoc README ChangeLog INSTALL build/resources/apache*

	# bug 254968
	insinto /etc/logrotate.d/
	newins "${FILESDIR}"/logrotate.d-munin munin

	dosym ipmi_ /usr/libexec/munin/plugins/ipmi_sensor_

	if use syslog; then
		sed -i -e '/log_file/s| .*| Sys::Syslog|' \
			"${D}"/etc/munin/munin-node.conf || die
	fi

	# Use a simpler pid file to avoid trouble with /run in tmpfs. The
	# munin-node service is ran as user root, and only later drops
	# privileges.
	sed -i -e 's:/var/run/munin/munin-node.pid:/var/run/munin-node.pid:' \
		"${D}"/etc/munin/munin-node.conf || die

	keepdir /var/lib/munin-async/.ssh /var/spool/munin-async
	touch "${D}"/var/lib/munin-async/.ssh/authorized_keys
	fowners munin-async /var/lib/munin-async/.ssh/{,authorized_keys}
	fperms 0700 /var/lib/munin-async/.ssh /var/spool/munin-async
	fperms 0600 /var/lib/munin-async/.ssh/authorized_keys

	if use minimal; then
		# This requires the presence of munin-update, which is part of
		# the non-minimal install...
		rm "${D}"/usr/libexec/munin/plugins/munin_stats
	else
		exeinto /etc/local.d/
		newexe "${FILESDIR}"/localstart-munin 50munin.start

		# remove font files so that we don't have to keep them around
		rm "${D}"/usr/libexec/${PN}/*.ttf || die

		if use cgi; then
			sed -i -e '/#graph_strategy cgi/s:^#::' "${D}"/etc/munin/munin.conf || die
		else
			sed -i -e '/#graph_strategy cgi/s:#graph_strategy cgi:graph_strategy cron:' "${D}"/etc/munin/munin.conf || die
		fi

		keepdir /var/lib/munin/.ssh
		cat - >> "${D}"/var/lib/munin/.ssh/config <<EOF
IdentityFile /var/lib/munin/.ssh/id_ecdsa
IdentityFile /var/lib/munin/.ssh/id_rsa
EOF

		fperms go-rwx /var/lib/munin/.ssh/{,config}

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

		# remove .htaccess file
		find "${D}" -name .htaccess -delete || die
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

	ebegin "Setting up cron ..."
	if has_version sys-process/fcron; then
		fcrontab - -u munin < /usr/share/${PN}/fcrontab
	else
		# dcron is very fussy about syntax
		# the following is the only form that works in BOTH dcron and vixie-cron
		crontab - -u munin < /usr/share/${PN}/crontab
	fi
	eend $?

	einfo "Press enter to set up the SSH keys used for SSH transport"
	read

	# generate one rsa (for legacy) and one ecdsa (for new systems)
	ssh-keygen -t rsa -f /var/lib/munin/.ssh/id_rsa -N '' -C "created by portage for ${CATEGORY}/${PN}" || die
	ssh-keygen -t ecdsa -f /var/lib/munin/.ssh/id_ecdsa -N '' -C "created by portage for ${CATEGORY}/${PN}" || die
	chown -R munin:munin /var/lib/munin/.ssh || die
	chmod 0600 /var/lib/munin/.ssh/id_{rsa,ecdsa} || die

	einfo "Your public keys are available in "
	einfo "  /var/lib/munin/.ssh/id_rsa.pub"
	einfo "  /var/lib/munin/.ssh/id_ecdsa.pub"
	einfo "and follows for convenience"
	echo
	cat /var/lib/munin/.ssh/id_*.pub
}

pkg_postinst() {
	elog "Please follow the munin documentation to set up the plugins you"
	elog "need, afterwards start munin-node via /etc/init.d/munin-node."
	elog ""
	elog "To make use of munin-async, make sure to set up the corresponding"
	elog "SSH key in /var/lib/munin-async/.ssh/authorized_keys"
	elog ""
	if ! use minimal; then
		elog "Please run"
		elog "  emerge --config net-analyzer/munin"
		elog "to automatically configure munin's cronjobs as well as generate"
		elog "passwordless SSH keys to be used with munin-async."
	fi
	elog ""
	elog "Further information about setting up Munin in Gentoo can be found"
	elog "in the Gentoo Wiki: https://wiki.gentoo.org/wiki/Munin"
}
