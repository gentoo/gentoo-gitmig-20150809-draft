# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.8.3.1.ebuild,v 1.5 2009/01/26 18:37:26 vapier Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"
AT_M4DIR=m4

inherit eutils autotools

DESCRIPTION="The de facto standard for intrusion detection/prevention"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz
	community-rules? ( http://www.snort.org/pub-bin/downloads.cgi/Download/comm_rules/Community-Rules-CURRENT.tar.gz )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE="static debug threads prelude stream4udp memory-cleanup decoder-preprocessor-rules ipv6 targetbased dynamicplugin timestats ruleperf ppm perfprofiling linux-smp-stats inline inline-init-failopen flexresp flexresp2 react aruba gre mpls postgres mysql odbc selinux community-rules"

#flexresp, react, and inline _ONLY_ work with net-libs/libnet-1.0.2a
DEPEND="virtual/libc
	virtual/libpcap
	>=sys-devel/libtool-1.4
	>=dev-libs/libpcre-6.0
	flexresp2? ( dev-libs/libdnet )
	flexresp? ( ~net-libs/libnet-1.0.2a )
	react? ( ~net-libs/libnet-1.0.2a )
	postgres? ( virtual/postgresql-base )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	prelude? ( >=dev-libs/libprelude-0.9.0 )
	inline? ( ~net-libs/libnet-1.0.2a net-firewall/iptables )"

RDEPEND="${DEPEND}
	dev-lang/perl
	selinux? ( sec-policy/selinux-snort )"

pkg_setup() {
	enewgroup snort
	enewuser snort -1 -1 /dev/null snort

	if use flexresp && use flexresp2 ; then
		ewarn
		ewarn
		ewarn "You have both the 'flexresp' and 'flexresp2' USE"
		ewarn "flags set. You can use 'flexresp' OR 'flexresp2'"
		ewarn "but not both."
		ewarn
		ewarn "Defaulting to flexresp2..."
		ewarn
		ewarn
		epause
	fi

	if use memory-cleanup && ! use dynamicplugin; then
		ewarn
		ewarn
		ewarn "You have enabled 'memory-cleanup' but not 'dynamicplugin'."
		ewarn "'memory-cleanup' requires 'dynamicplugin' to compile."
		ewarn
		ewarn "Enabling dynamicplugin..."
		ewarn
		ewarn
		epause
	fi

	if use ruleperf && ! use dynamicplugin; then
		ewarn
		ewarn
		ewarn "You have enabled 'ruleperf' but not 'dynamicplugin'."
		ewarn "'ruleperf' requires 'dynamicplugin' to compile."
		ewarn
		ewarn "Enabling dynamicplugin..."
		ewarn
		ewarn
		epause
	fi

	if use inline-init-failopen && ! use inline; then
		ewarn
		ewarn
		ewarn "You have enabled 'inline-init-failopen' but not 'inline'."
		ewarn "'inline-init-failopen' is an 'inline' only function."
		ewarn
		ewarn "Enabling inline mode..."
		ewarn
		ewarn
		epause
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Dont monkey with the original source if you don't need to.
	if use flexresp || use react || use inline; then
	        epatch "${FILESDIR}/${PN}-2.8.3.1-libnet.patch"
	fi

	if use prelude ; then
		sed -i -e "s:AC_PROG_RANLIB:AC_PROG_LIBTOOL:" configure.in
	fi

	einfo "Regenerating autoconf/automake files"
	eautoreconf
}

src_compile() {
	local myconf

	#Both shared and static are enable by defaut so we need to be specific
	if use static; then
		myconf="${myconf} --enable-static --disable-shared"
	else
		myconf="${myconf} --disable-static --enable-shared"
	fi

	#Added in ebuild version snort-2.8.3.1. Should be rechecked in updated versions.
	#Use 'die' because ./configure will die any ways with the same error message...
	if use ipv6 && use targetbased; then
		die "Support for target-based and IPv6 cannot be enabled simultaneously in this version."
	fi

	#Sourcefire is often not clear about what is and is not enabled by default
	#To avoid undesired results we should be very specific
	if use flexresp && ! use flexresp2; then
		myconf="${myconf} --enable-flexresp --disable-flexresp2"
	elif use flexresp2 && ! use flexresp; then
		myconf="${myconf} --disable-flexresp --enable-flexresp2"
	elif use flexresp && use flexresp2; then
		myconf="${myconf} --disable-flexresp --enable-flexresp2"
	fi

	# USE flages memory-cleanup and ruleperf require dynamicplugin
	#Only 'dynamicplugin' is set here. 'ruleperf' and 'memory-cleanup' are set below via econf.
	if use memory-cleanup || use ruleperf || use dynamicplugin; then
		myconf="${myconf} --enable-dynamicplugin"
	else
		myconf="${myconf} --disable-dynamicplugin"
	fi

	# USE flages 'targetbased' and 'inline-init-failopen' require threads
	#Only 'threads' is set here. 'targetbased' and 'inline-init-failopen' are set below via econf.
	if use targetbased || use inline-init-failopen || use threads; then
		myconf="${myconf} --enable-pthread"
	else
		myconf="${myconf} --disable-pthread"
	fi

	#Only needed if...
	if use flexresp || use react || use inline; then
		myconf="${myconf} --with-libipq-includes=/usr/include/libipq"
	fi

	#'inline-init-failopen' requires 'inline'
	if use inline-init-failopen || use inline; then
		myconf="${myconf} --enable-inline"
	else
		myconf="${myconf} --disable-inline"
	fi

#The --enable-<feature> options... 'static' 'dynamicplugin' 'threads' 'flexresp' 'flexresp2' 'inline'
# are configured above due to dependancy/conflict issues.
#All others are handled the standard ebuild way via econf

	econf \
		--without-oracle \
		$(use_with postgres postgresql) \
		$(use_with mysql) \
		$(use_with odbc) \
		--disable-ipfw \
		--disable-profile \
		--disable-ppm-test \
		$(use_enable debug) \
		$(use_enable prelude) \
		$(use_enable stream4udp) \
		$(use_enable memory-cleanup) \
		$(use_enable decoder-preprocessor-rules) \
		$(use_enable ipv6) \
		$(use_enable targetbased) \
		$(use_enable timestats) \
		$(use_enable ruleperf) \
		$(use_enable ppm) \
		$(use_enable perfprofiling) \
		$(use_enable linux-smp-stats) \
		$(use_enable inline-init-failopen) \
		$(use_enable react) \
		$(use_enable aruba) \
		$(use_enable gre) \
		$(use_enable mpls) \
		${myconf} || die "econf failed"

	# limit to single as reported by jforman on irc
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	keepdir /var/log/snort/

	dodoc doc/*
	dodoc ./RELEASE.NOTES
	docinto schemas ; dodoc schemas/*

	insinto /etc/snort
	doins etc/reference.config \
	      etc/classification.config \
	      etc/*.map \
	      etc/threshold.conf \
	      etc/attribute_table.dtd \
	      etc/unicode.map

	# Make some changes to snort.conf depending on the users feature selection
	if use memory-cleanup || use ruleperf || use dynamicplugin; then
		sed -e "s:/usr/local/lib:/usr/$(get_libdir):g" \
			etc/snort.conf > "${D}"/etc/snort/snort.conf.distrib
	else
		sed -e "s:^dynamic:# dynamic:g" \
			etc/snort.conf > "${D}"/etc/snort/snort.conf.distrib
	fi

	sed -i -e "s:RULE_PATH ../rules:RULE_PATH /etc/snort/rules:g" \
		"${D}"/etc/snort/snort.conf.distrib

	sed -i -e "s:PREPROC_RULE_PATH ../preproc_rules:PREPROC_RULE_PATH /etc/snort/preproc_rules:g" \
		"${D}"/etc/snort/snort.conf.distrib

	sed -i -e "s:^include $RULE_PATH:#include $RULE_PATH:g" \
		"${D}"/etc/snort/snort.conf.distrib

	newinitd "${FILESDIR}/snort.rc8" snort
	newconfd "${FILESDIR}/snort.confd" snort

	fowners snort:snort /var/log/snort
	fperms 0770 /var/log/snort

	# Install Community rules if enabled
	if use community-rules; then
		insinto /etc/snort/rules
		doins -r "${WORKDIR}"/rules/*
	fi

	# Install preproc_rules if enabled
	if use decoder-preprocessor-rules; then
		insinto /etc/snort/preproc_rules
		doins -r "${WORKDIR}"/${P}/preproc_rules/*.rules
	fi
}

pkg_postinst() {
	elog
	elog "If you find that snort is using too much memory, your system"
	elog "freezes, or snort crashes after a few minutes try adding the"
	elog "following to your snort.conf..."
	elog
	elog "'config detection: search-method ac-sparsebands'"
	elog
	elog  "To use a database backend with snort you will have to create"
	elog  "a database, a database user, and import the snort schema."
	elog  "The schema files are located in..."
	elog
	elog  "/usr/share/doc/${PF}/schemas/"
	elog
	elog  "Instructions for seting up your database, user, and schema imports"
	elog  "can be found in the README.database file located in..."
	elog
	elog  "/usr/share/doc/${PF}"
	elog
	elog  "Users using the unified output plugin and barnyard do not need to"
	elog  "compile database support into snort, but still need to set up their"
	elog  "database as documented in README.database."
	elog
	if use community-rules; then
		elog
		elog "The COMMUNITY ruleset has been installed."
		elog
	else
		elog
		elog "The COMMUNITY ruleset has NOT been installed."
		elog
	fi
		elog "To learn how to manage updates to your rulesets please visit..."
		elog
		elog "http://oinkmaster.sourceforge.net/"
		elog
		elog "and then 'emerge oinkmaster'. Once oinkmaster is configured,"
		elog "you may want to disable the 'community-rules' USE flag."
		elog
		elog "It is HIGHLY recomended that you also download Sourcefire's VRT"
		elog "ruleset also. For more information on obtaining the VRT ruleset,"
		elog "please visit... http://www.snort.org/vrt/"
		elog
}
