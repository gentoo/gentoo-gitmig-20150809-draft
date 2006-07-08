# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.6.0.ebuild,v 1.1 2006/07/08 01:40:13 vanquirius Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="Libpcap-based packet sniffer/logger/lightweight IDS"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/current/${P}.tar.gz
	http://www.snort.org/pub-bin/downloads.cgi/Download/comm_rules/Community-Rules.tar.gz
	http://www.snort.org/pub-bin/downloads.cgi/Download/vrt_pr/snortrules-pr-2.4.tar.gz
	snortsam? ( mirror://gentoo/snortsam-20050110.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-alpha ~amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE="ssl postgres mysql flexresp selinux snortsam odbc prelude inline sguil dynamicplugin timestats perfprofiling linux-smp-stats"

DEPEND="virtual/libc
	>=dev-libs/libpcre-4.2-r1
	virtual/libpcap
	flexresp? ( ~net-libs/libnet-1.0.2a )
	postgres? ( >=dev-db/postgresql-7.2 )
	mysql? ( >=dev-db/mysql-3.23.26 )
	ssl? ( >=dev-libs/openssl-0.9.6b )
	prelude? ( >=dev-libs/libprelude-0.9.0 )
	odbc? ( dev-db/unixODBC )
	>=sys-devel/libtool-1.4
	inline? (
		~net-libs/libnet-1.0.2a
		net-firewall/iptables
		)"

RDEPEND="${DEPEND}
	dev-lang/perl
	selinux? ( sec-policy/selinux-snort )
	snortsam? ( net-analyzer/snortsam )"

pkg_setup() {
	enewgroup snort
	enewuser snort -1 -1 /dev/null snort
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	if use flexresp || use inline ; then
		epatch "${WORKDIR}/2.4.0-libnet-1.0.patch"
	fi

	sed -i "s:var RULE_PATH ../rules:var RULE_PATH /etc/snort/rules:" \
		etc/snort.conf || die "sed snort.conf failed"

	if use prelude ; then
		sed -i -e "s:AC_PROG_RANLIB:AC_PROG_LIBTOOL:" configure.in \
			|| die "sed configure.in failed"
	fi

	if use sguil ; then
		epatch "${WORKDIR}/2.4.0-spp_portscan_sguil.patch"
		epatch "${WORKDIR}/2.4.0-spp_stream4_sguil.patch"
	fi

	if use snortsam ; then
		cd ..
		einfo "Applying snortsam patch"
		./patchsnort.sh "${S}" || die "snortsam patch failed"
		cd "${S}"
	fi

	einfo "Regenerating autoconf/automake files"
	AT_M4DIR=m4 eautoreconf
}

src_compile() {
	local myconf

	# There is no --disable-flexresp, cannot use use_enable
	use flexresp && myconf="${myconf} --enable-flexresp"

	use inline && append-flags -I/usr/include/libipq

	econf \
		$(use_with postgres postgresql) \
		$(use_with mysql) \
		$(use_with ssl openssl) \
		$(use_with odbc) \
		--without-oracle \
		$(use_enable prelude) \
		$(use_with sguil) \
		$(use_enable inline) \
		$(use_enable dynamicplugin) \
		$(use_enable timestats) \
		$(use_enable perfprofiling) \
		$(use_enable linux-smp-stats) \
		${myconf} || die "bad ./configure"

	emake || die "compile problem"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	keepdir /var/log/snort/

	dodoc doc/*
	dodoc ./RELEASE.NOTES
	docinto schemas ; dodoc schemas/*

	insinto /etc/snort
	doins etc/reference.config etc/classification.config \
		etc/*.map etc/threshold.conf
	newins etc/snort.conf snort.conf
	if use sguil ; then
		sed -i -e "/^# output log_unified/s:# ::" \
			-e "s:snort.log:snort_unified.log:" \
		"${D}/etc/snort/snort.conf" || die "sed failed"
	fi

	newinitd "${FILESDIR}/snort.rc7" snort
	newconfd "${FILESDIR}/snort.confd" snort
	if use sguil ; then
		sed -i -e "s:/var/log/snort:/var/lib/sguil/$(hostname):" \
		-e "/^SNORT_OPTS/s%-u snort%-m 122 -u sguil -g sguil -A none%" \
			"${D}/etc/conf.d/snort" || die "sed failed"
	fi

	fowners snort:snort /var/log/snort
	fperms 0770 /var/log/snort

	# install rules
	dodir /etc/snort/rules
	mv "${WORKDIR}"/rules/* "${D}/etc/snort/rules/"
}

pkg_postinst() {
	ewarn
	ewarn "Users upgrading from snort 2.4.x should take care when updating"
	ewarn "their snort.conf. A number of significant changes have been"
	ewarn "have been added to snort 2.6 including the addition of"
	ewarn "dynamically loadable preprocessors, detection engine and rules."
	ewarn "Snort 2.6 also includes the addition of performance profiling"
	ewarn "for rules & preprocessors and uses a new default pattern matcher"
	ewarn "which provides faster matching at the expense of being very"
	ewarn "memory intensive."
	ewarn
	ewarn "If you find that snort is using too much memory, your system"
	ewarn "freezes, or snort crashes after a few minutes try adding the"
	ewarn "following to your snort.conf..."
	ewarn
	ewarn "'config detection: search-method ac-sparsebands'"
	ewarn
	ewarn "This will provide high pattern matching performance at a much"
	ewarn "lower cost to memory. For more information on the new features"
	ewarn "in snort 2.6, please take a look at the release notes located in..."
	ewarn
	ewarn "  /usr/share/doc/${PF}/RELEASE.NOTES.gz"
	ewarn
	einfo "To use a database as a backend for snort you will have to"
	einfo "import the correct tables to the database."
	einfo "You will have to setup a database called snort before doing the"
	einfo "following..."
	einfo
	einfo "  MySQL: zcat /usr/share/doc/${PF}/schemas/create_mysql.gz | mysql -p snort"
	einfo
	einfo "  PostgreSQL: import /usr/share/doc/${PF}/schemas/create_postgresql.gz"
	einfo
	einfo "  ODBC: look at /usr/share/doc/${PF}/schemas/"
	einfo
	einfo "Users using the unified output plugin and barnyard do not need to"
	einfo "compile database support into snort, but still need to set up their"
	einfo "database as shown above."
	einfo
	ewarn "Only a basic set of rules was installed."
	ewarn "Please add your other sets of rules to /etc/snort/rules."
	ewarn "For more information on rules, visit ${HOMEPAGE}."
}
