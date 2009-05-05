# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.8.4.1.ebuild,v 1.1 2009/05/05 20:52:10 patrick Exp $

inherit eutils autotools multilib

DESCRIPTION="The de facto standard for intrusion detection/prevention"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/dl/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 -sparc ~x86"
IUSE="static debug threads prelude memory-cleanup dynamicplugin decoder-preprocessor-rules ipv6 targetbased timestats ppm perfprofiling linux-smp-stats inline inline-init-failopen flexresp flexresp2 react aruba gre mpls postgres mysql odbc selinux"

#flexresp, react, and inline _ONLY_ work with net-libs/libnet-1.0.2a
DEPEND="virtual/libpcap
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

	if use ipv6 && use prelude; then
		ewarn
		ewarn
		ewarn "You have enabled 'prelude' and 'ipv6'."
		ewarn "The Prelude output plugin does not support ipv6."
		ewarn
		ewarn "Disabling ipv6 support..."
		ewarn
		ewarn
		epause
	fi

	# pre_inst() is a better place but we need it here for the 
	#'fowners' statements in src_install()
	enewgroup snort
	enewuser snort -1 -1 /dev/null snort

}

src_unpack() {
	unpack ${A}
	cd "${S}"

	#Dont monkey with the original source if you don't need to.
	if use flexresp || use react || use inline || use inline-init-failopen; then
	        epatch "${FILESDIR}/${PN}-2.8.4-libnet.patch"
	fi

	#Added patch to print the value of PCAP_MEMORY
	epatch "${FILESDIR}/pcap_memory.patch"

	#Multilib fix for the sf_engine
	sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
		"${WORKDIR}/${P}/src/dynamic-plugins/sf_engine/Makefile.am" \
		|| die "sed for sf_engine failed"

	#Multilib fix for the curent set of dynamic-preprocessors
	for i in ftptelnet smtp ssh dcerpc dns ssl dcerpc2; do
		sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
			"${WORKDIR}/${P}/src/dynamic-preprocessors/$i/Makefile.am" \
			|| die "sed for $i failed."
	done

	#This sed will prevent the example dynamic code from being compiled/installed
	sed -i -e 's:$(EXAMPLES_DIR)::g' "${WORKDIR}/${P}/src/Makefile.am"

	if use prelude ; then
		sed -i -e "s:AC_PROG_RANLIB:AC_PROG_LIBTOOL:" configure.in
	fi

	AT_M4DIR=m4 eautoreconf
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
	#Also, See the next 'if' for "react"
	if ! use react && use flexresp && ! use flexresp2; then
		myconf="${myconf} --enable-flexresp --disable-flexresp2"
	elif ! use react && ! use flexresp && use flexresp2; then
		myconf="${myconf} --disable-flexresp --enable-flexresp2"
	elif ! use react && use flexresp && use flexresp2; then
		myconf="${myconf} --disable-flexresp --enable-flexresp2"
	elif ! use react && ! use flexresp && ! use flexresp2; then
		myconf="${myconf} --disable-flexresp --disable-flexresp2"
	fi

	#We need to do this becaue 'react' automaticly enables 'flexresp'
	#but ./configure fails if both --enable-react and --enable-flexresp
	#are used. Here is the error...
	#ERROR!  --enable-react cannot be used with --enable-flexresp
	#because it is AUTOMATICALLY enabled with --enable-flexresp
	#Given that --enable-flexresp is enable we know that 
	#--disable-flexresp2 should be used
	if use react; then
		myconf="${myconf} --enable-react --disable-flexresp2"
	fi

	#USE flag memory-cleanup requires dynamicplugin
	#Only 'dynamicplugin' is set here, 'memory-cleanup' is set below via econf.
	if use memory-cleanup || use dynamicplugin; then
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

	#'prelude' does not support 'ipv6'
	if use ipv6 && use prelude; then
		myconf="${myconf} --enable-prelude --disable-ipv6"
	elif use ipv6 && ! use prelude; then
		myconf="${myconf} --enable-ipv6"
	elif use prelude && ! use ipv6; then
		myconf="${myconf} --enable-prelude"
	elif ! use prelude && ! use ipv6; then
		myconf="${myconf} --disable-prelude --disable-ipv6"
	fi


#The --enable-<feature> options... 
#'static' 'threads' 'react' 'flexresp' 'flexresp2' 'inline' 'dynamicplugin'
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
		$(use_enable memory-cleanup) \
		$(use_enable decoder-preprocessor-rules) \
		$(use_enable targetbased) \
		$(use_enable timestats) \
		$(use_enable ppm) \
		$(use_enable perfprofiling) \
		$(use_enable linux-smp-stats) \
		$(use_enable inline-init-failopen) \
		$(use_enable aruba) \
		$(use_enable gre) \
		$(use_enable mpls) \
		${myconf} || die "econf failed"

	# limit to single as reported by jforman on irc
	emake -j1

}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	keepdir /var/log/snort/
	fowners snort:snort /var/log/snort

	keepdir /var/run/snort/
	fowners snort:snort /var/run/snort/

	dodoc doc/*
	dodoc ./RELEASE.NOTES
	docinto schemas
	dodoc schemas/*

	insinto /etc/snort
	doins etc/attribute_table.dtd \
		etc/classification.config \
		etc/gen-msg.map \
		etc/reference.config \
		etc/sid-msg.map \
		etc/threshold.conf \
		etc/unicode.map \
		|| die "Failed to add files in /etc/snort"

	newins etc/snort.conf snort.conf.distrib

	insinto /etc/snort/preproc_rules
	doins preproc_rules/decoder.rules \
		preproc_rules/preprocessor.rules \
		|| die "Failed to add files in /etc/snort/preproc_rules"

	keepdir /etc/snort/rules/

	fowners -R snort:snort /etc/snort/

	newinitd "${FILESDIR}/snort.rc9" snort || die "Failed to add snort.rc9"
	newconfd "${FILESDIR}/snort.confd" snort || die "Failed to add snort.confd"


	# Make some changes to snort.conf.distrib

	# Set the correct lib path for dynamicengine, dynamicpreprocessor, and dynamicdetection
	sed -i -e 's:/usr/local/lib:/usr/'$(get_libdir)':g' \
		"${D}etc/snort/snort.conf.distrib"

	#Set the correct rule location in the config
	sed -i -e 's:RULE_PATH ../rules:RULE_PATH /etc/snort/rules:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Set the correct preprocessor/decoder rule location in the config
	sed -i -e 's:PREPROC_RULE_PATH ../preproc_rules:PREPROC_RULE_PATH /etc/snort/preproc_rules:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Enable the preprocessor/decoder rules
	sed -i -e 's:^# include $PREPROC_RULE_PATH:include $PREPROC_RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib"
	sed -i -e 's:^# dynamicdetection directory:dynamicdetection directory:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Just some clean up of trailing /'s in the config
	sed -i -e 's:snort_dynamicpreprocessor/$:snort_dynamicpreprocessor:g' \
		"${D}etc/snort/snort.conf.distrib"
	sed -i -e 's:snort_dynamicrule/$:snort_dynamicrules:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Make it clear in the config where these are...
	sed -i -e 's:^include classification.config:include /etc/snort/classification.config:g' \
		"${D}etc/snort/snort.conf.distrib"
	sed -i -e 's:^include reference.config:include /etc/snort/reference.config:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Disable all rule files by default.
	#Users need to chose what they want enabled.
	sed -i -e 's:^include $RULE_PATH:# include $RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib"

}

pkg_postinst() {
	einfo
	einfo "Snort is a libpcap based packet capture tool which can be used in"
	einfo "three modes Sniffer Mode, Packet Logger Mode, or Network Intrusion"
	einfo "Detection System Mode."
	einfo
	einfo "To learn more about these modes review the Snort User Manual at..."
	einfo
	einfo "http://www.snort.org/docs/"
	einfo
	einfo "See /usr/share/doc/${PF} and /etc/snort/snort.conf.distrib for"
	einfo "information on configuring snort."
	einfo
	einfo "Joining the Snort Users and Snort Sigs mailing list is highly"
	einfo "recommended for all users..."
	einfo
	einfo "http://www.snort.org/community/lists.html"
	einfo
	elog "Snort-2.8.4.1 Notes:"
	elog
	elog "The 'community-rules' USE flag has been removed."
	elog
	elog "We are no longer distributing rule files via the snort ebuild."
	elog "There are a couple of reasons for this change..."
	elog
	elog "1. Rule files are not versioned making it impossible to use"
	elog "   portage to update them properly."
	elog "2. Although some of the rules are still useful, the"
	elog "   Community Rules are quite old (RELEASED: 2007-04-27) and"
	elog "   should only be used to supplement the VRT rule set."
	elog "3. Sourcefire's VRT rule set requires users to register (for free)"
	elog "   to download them."
	elog "4. Certain versions of Snort require specific rule set versions"
	elog "   for proper detection and to prevent Snort from breaking."
	elog "  (See below.)"
	elog
	elog "To download rules for use with Snort please, see the following"
	elog
	elog "Sourcefire's VRT Rules and older Community Rules:"
	elog "http://www.snort.org/pub-bin/downloads.cgi"
	elog
	elog "Emerging Threats Rules:"
	elog "http://www.emergingthreats.net/"
	elog
	elog "A good place to put your downloaded rules would be..."
	elog "/etc/snort/rules"
	elog
	elog "To manage updates to your rules please visit..."
	elog
	elog "http://oinkmaster.sourceforge.net/"
	elog
	elog "and then 'emerge oinkmaster'."
	elog
	elog "!!!IMPORTANT!!!"
	elog "Users upgrading from versions prior to Snort-2.8.4 and are using"
	elog "the dcerpc or dcerpc2 preprocessor in your snort.conf file"
	elog "with the netbios rules should be aware of the following"
	elog "announcements..."
	elog
	elog "http://vrt-sourcefire.blogspot.com/2009/04/snort-284-is-nigh.html"
	elog "http://vrt-sourcefire.blogspot.com/2009/02/important-snort-rule-changes-and-new.html"
	elog
}
