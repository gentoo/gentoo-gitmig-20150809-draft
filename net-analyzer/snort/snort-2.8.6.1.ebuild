# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/snort/snort-2.8.6.1.ebuild,v 1.1 2010/08/13 11:12:02 patrick Exp $

EAPI="2"
inherit eutils autotools multilib

DESCRIPTION="The de facto standard for intrusion detection/prevention"
HOMEPAGE="http://www.snort.org/"
SRC_URI="http://www.snort.org/downloads/116 -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ppc ~ppc64 ~sparc ~x86"
IUSE="static dynamicplugin ipv6 gre mpls targetbased decoder-preprocessor-rules
ppm timestats perfprofiling linux-smp-stats inline inline-init-failopen prelude
threads debug reload reload-error-restart flexresp flexresp2 react aruba mysql
odbc postgres selinux zlib"

#flexresp, react, and inline _ONLY_ work with net-libs/libnet-1.0.2a
DEPEND="virtual/libpcap
	>=dev-libs/libpcre-6.0
	flexresp2? ( dev-libs/libdnet )
	flexresp? ( ~net-libs/libnet-1.0.2a )
	react? ( ~net-libs/libnet-1.0.2a )
	postgres? ( dev-db/postgresql-base )
	mysql? ( virtual/mysql )
	odbc? ( dev-db/unixODBC )
	prelude? ( >=dev-libs/libprelude-0.9.0 )
	inline? ( ~net-libs/libnet-1.0.2a net-firewall/iptables )
	zlib? ( sys-libs/zlib )"

RDEPEND="${DEPEND}
	dev-lang/perl
	selinux? ( sec-policy/selinux-snort )"

pkg_setup() {

	if use flexresp && use flexresp2; then
		eerror
		eerror "You have both the 'flexresp' and 'flexresp2' USE flags set."
		eerror "You can use 'flexresp' OR 'flexresp2' but not both."
		eerror "flexresp2 is recommended."
		eerror
		eerror
		die
	elif use flexresp && use react; then
		eerror
		eerror "You have both the 'react' and 'flexresp' USE flags set."
		eerror "'react' is enabled automaticly when the 'flexresp'"
		eerror "USE flag is set, but ./configure will fail if both are enabled."
		eerror
		eerror "This is an upstream issue and not a problem with this ebuild."
		eerror
		eerror "To enable both 'flexresp' and 'react' set USE="flexresp -react""
		eerror
		eerror
		die
	elif use flexresp2 && use react; then
		eerror
		eerror "You have both the 'react' and 'flexresp2' USE flags set."
		eerror "You can use 'react' OR 'flexresp2' but not both."
		eerror
		eerror
		die
	elif use inline-init-failopen && ! use inline; then
		eerror
		eerror "You have enabled the 'inline-init-failopen' USE flag"
		eerror "but not the 'inline' USE flag."
		eerror "'inline-init-failopen' requires 'inline' be enabled."
		eerror
		eerror
		die
	elif use reload-error-restart && ! use reload; then
		eerror
		eerror "You have enabled the 'reload-error-restart' USE flag"
		eerror "but not the 'reload' USE flag."
		eerror "'reload-error-restart' requires 'reload' be enabled."
		eerror
		eerror
		die
	elif use zlib && ! use dynamicplugin; then
		eerror
		eerror "You have enabled the 'zlib' USE flag but not the 'dynamicplugin' USE flag."
		eerror "'zlib' requires 'dynamicplugin' be enabled."
		eerror
		eerror
		die
	fi

	# pre_inst() is a better place to put this
	# but we need it here for the 'fowners' statements in src_install()
	enewgroup snort
	enewuser snort -1 -1 /dev/null snort

}

src_unpack() {

	unpack ${A}
	cd "${S}"

}

src_prepare() {

	# Fix to prevent the docs Makefile from being used.
	# Fixes #297190.
	einfo "Applying documentation fix."
	sed -i -e 's:src doc etc:src etc:g' \
		"${WORKDIR}/${P}/Makefile.am" || die "Doc fix Failed"

	#Replaces the libnet-1.0 patch for inline, flexresp, and react
	if use flexresp || use react || use inline; then

		einfo "Applying libnet-1.0 fix."
		sed -i -e 's:libnet.h:libnet-1.0.h:g' \
			"${WORKDIR}/${P}/configure.in" \
			"${WORKDIR}/${P}/src/detection-plugins/sp_react.c" \
			"${WORKDIR}/${P}/src/detection-plugins/sp_respond.c" \
			"${WORKDIR}/${P}/src/inline.c" || die "sed for libnet-1.0.h failed"

		sed -i -e 's:libnet-config:libnet-1.0-config:g' \
			"${WORKDIR}/${P}/configure.in" || die "sed for libnet-1.0-config failed"

		sed -i -e 's:-lnet:-lnet-1.0:g' \
			"${WORKDIR}/${P}/configure.in" || die "sed for -lnet-1.0 failed"

		sed -i -e 's:AC_CHECK_LIB(net:AC_CHECK_LIB(net-1.0:g' \
			"${WORKDIR}/${P}/configure.in" || die "sed for net-1.0 failed"

	fi

	#Multilib fix for the sf_engine
	einfo "Applying multilib fix."
	sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
		"${WORKDIR}/${P}/src/dynamic-plugins/sf_engine/Makefile.am" \
		|| die "sed for sf_engine failed"

	#Multilib fix for the curent set of dynamic-preprocessors
	for i in ftptelnet smtp ssh dcerpc dns ssl dcerpc2 sdf; do
		sed -i -e 's:${exec_prefix}/lib:${exec_prefix}/'$(get_libdir)':g' \
			"${WORKDIR}/${P}/src/dynamic-preprocessors/$i/Makefile.am" \
			|| die "sed for $i failed."
	done

	if use prelude; then
		einfo "Applying prelude fix."
		sed -i -e "s:AC_PROG_RANLIB:AC_PROG_LIBTOOL:" configure.in
	fi

	AT_M4DIR=m4 eautoreconf
}

src_configure() {

	local myconf

	#targetbased and inline-init-failopen automaticly enable pthread
	if use threads || use targetbased || use inline-init-failopen; then
		myconf="${myconf} --enable-pthread"
	fi

	#Tell flexresp, react, and inline where libipq is
	if use flexresp || use react || use inline; then
		myconf="${myconf} --with-libipq-includes=/usr/include/libipq"
	fi

	econf \
		$(use_enable !static shared) \
		$(use_enable static) \
		$(use_enable dynamicplugin) \
		$(use_enable ipv6) \
		$(use_enable gre) \
		$(use_enable mpls) \
		$(use_enable targetbased) \
		$(use_enable decoder-preprocessor-rules) \
		$(use_enable ppm) \
		$(use_enable timestats) \
		$(use_enable perfprofiling) \
		$(use_enable linux-smp-stats) \
		$(use_enable inline) \
		$(use_enable inline-init-failopen) \
		$(use_enable prelude) \
		$(use_enable debug) \
		$(use_enable reload) \
		$(use_enable reload-error-restart) \
		$(use_enable flexresp) \
		$(use_enable flexresp2) \
		$(use_enable react) \
		$(use_enable aruba) \
		$(use_enable zlib) \
		$(use_with mysql) \
		$(use_with odbc) \
		$(use_with postgres postgresql) \
		--disable-build-dynamic-examples \
		--disable-corefiles \
		--disable-ipfw \
		--disable-profile \
		--disable-ppm-test \
		--without-oracle \
		${myconf}

}

src_compile() {

	emake || die "make failed"

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

	keepdir /usr/$(get_libdir)/snort_dynamicrule

	fowners -R snort:snort /etc/snort/

	if use reload; then
		newinitd "${FILESDIR}/snort.reload.rc1" snort \
			|| die "Failed to add snort.reload.rc1"
	else
		newinitd "${FILESDIR}/snort.rc9" snort || die "Failed to add snort.rc9"
	fi

	newconfd "${FILESDIR}/snort.confd" snort || die "Failed to add snort.confd"

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

	#Make it clear in the config where these are...
	sed -i -e 's:^include classification.config:include /etc/snort/classification.config:g' \
		"${D}etc/snort/snort.conf.distrib"
	sed -i -e 's:^include reference.config:include /etc/snort/reference.config:g' \
		"${D}etc/snort/snort.conf.distrib"

	#Disable all rule files by default.
	#Users need to choose what they want enabled.
	sed -i -e 's:^include $RULE_PATH:# include $RULE_PATH:g' \
		"${D}etc/snort/snort.conf.distrib"

}

pkg_postinst() {
	einfo
	einfo "Snort is a libpcap based packet capture tool which can be used in"
	einfo "three modes Sniffer Mode, Packet Logger Mode, or Network Intrusion"
	einfo "Detection/Prevention System Mode."
	einfo
	einfo "To learn more about these modes review the Snort User Manual at..."
	einfo
	einfo "http://www.snort.org/docs/"
	einfo
	einfo "See /usr/share/doc/${PF} and /etc/snort/snort.conf.distrib for"
	einfo "information on configuring snort."
	einfo
	einfo "Joining the Snort-Users and Snort-Sigs mailing list is highly"
	einfo "recommended for all users..."
	einfo
	einfo "http://www.snort.org/community/mailing-lists/"
	einfo
	einfo "To download rules for use with Snort please, see the following"
	einfo
	einfo "Sourcefire's VRT Rules and older Community Rules:"
	einfo "http://www.snort.org/pub-bin/downloads.cgi"
	einfo
	einfo "Emerging Threats Rules:"
	einfo "http://www.emergingthreats.net/"
	einfo
	einfo "To manage updates to your rules please visit..."
	einfo
	einfo "http://code.google.com/p/pulledpork/"
	einfo
	elog
	elog "Snort Release Notes:"
	elog "http://www.snort.org/snort-downloads"
	elog
	elog
	elog "Shared Object (SO) rules and registered (non-subscription) rule users:"
	elog
	elog "Please note, you can not use Snort-2.8.6.1 with the SO rules from"
	elog "the 2.8.6.0 rule tarball. If you do not have a subscription to the VRT ruleset"
	elog "and you wish to continue using SO rules you will need to downgrade to"
	elog "Snort-2.8.6. The SO rules will be made available to registered"
	elog "(non-subscription) rule users on Sept. 22, 2010 (30 days after"
	elog "being released to subscription users)."
	elog
	elog "Please see http://www.snort.org/snort-rules/#rules for more details."
	elog
}
