# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/psad/psad-1.3.4.ebuild,v 1.10 2006/12/10 10:55:18 phreak Exp $

inherit eutils perl-app

IUSE=""

DESCRIPTION="Port Scanning Attack Detection daemon"
SRC_URI="http://www.cipherdyne.org/psad/download/${P}.tar.bz2"
HOMEPAGE="http://www.cipherdyne.org/psad"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc alpha ~sparc"

DEPEND="${DEPEND}
	dev-lang/perl"

RDEPEND="virtual/logger
	dev-perl/Unix-Syslog
	dev-perl/Date-Calc
	virtual/mailx
	net-firewall/iptables"

src_compile() {
	cd ${S}/Psad
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/Net-IPv4Addr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/IPTables/Parse
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/whois
	emake || die "Make failed: whois"

	cd ${S}
	# We'll use the C binaries
	emake || die "Make failed: daemons"
}

src_install() {
	local myhostname=
	local mydomain=

	doman *.8

	keepdir /var/lib/psad /var/log/psad /var/run/psad /var/lock/subsys/${PN}
	dodir /etc/psad
	cd ${S}/Psad
	insinto /usr/lib/psad
	doins Psad.pm

	cd ${S}/Net-IPv4Addr
	insinto /usr/lib/psad/Net
	doins IPv4Addr.pm

	cd ${S}/IPTables/Parse
	insinto /usr/lib/psad/IPTables
	doins Parse.pm

	cd ${S}/whois
	# Makefile seems borken, do install by hand...
	insinto /usr
	newbin whois whois_psad
	newman whois.1 whois_psad.1

	cd ${S}
	insinto /usr
	dosbin kmsgsd psad psadwatchd
	newsbin fwcheck_psad.pl fwcheck_psad
	dobin pscan

	cd ${S}

	fix_psad_conf

	insinto /etc/psad
	doins *.conf
	doins psad_*
	doins auto_dl icmp_types posf signatures

	cd ${S}/init-scripts
	exeinto /etc/init.d
	newexe psad-init.gentoo psad

	cd ${S}/snort_rules
	dodir /etc/psad/snort_rules
	insinto /etc/psad/snort_rules
	doins *.rules

	cd ${S}
	dodoc BENCHMARK CREDITS Change* FW_EXAMPLE_RULES README LICENSE SCAN_LOG
}

pkg_postinst() {
	if [ ! -p ${ROOT}/var/lib/psad/psadfifo ]
	then
		ebegin "Creating syslog FIFO for PSAD"
		mknod -m 600 ${ROOT}/var/lib/psad/psadfifo p
		eend $?
	fi

	echo
	einfo "Please be sure to edit /etc/psad/psad.conf to reflect your system's"
	einfo "configuration or it may not work correctly or start up. Specifically, check"
	einfo "the validity of the HOSTNAME setting and replace the EMAIL_ADDRESSES and"
	einfo "HOME_NET settings at the least."
	echo
	einfo "If you are using a logger other than sysklogd, please be sure to change the"
	einfo "syslogdCmd setting in /etc/psad/psad.conf. An example for syslog-ng users"
	einfo "would be:"
	einfo "		syslogdCmd	/usr/sbin/syslog-ng;"
}

fix_psad_conf() {
	cp psad.conf psad.conf.orig

	# Ditch the _CHANGEME_ for hostname, substituting in our real hostname
	[ -e /etc/hostname ] && myhostname="$(< /etc/hostname)"
	[ "${myhostname}" == "" ] && myhostname="$HOSTNAME"
	mydomain=".$(grep ^domain /etc/resolv.conf | cut -d" " -f2)"
	sed -i "s:HOSTNAME\(.\+\)\_CHANGEME\_;:HOSTNAME\1${myhostname}${mydomain};:" psad.conf || die "fix_psad_conf failed"

	# Fix up paths
	sed -i "s:/sbin/syslogd:/usr/sbin/syslogd:g" psad.conf || die "fix_psad_conf failed"
	sed -i "s:/sbin/syslog-ng:/usr/sbin/syslog-ng:g" psad.conf || die "fix_psad_conf failed"
	sed -i "s:/bin/uname:/usr/bin/uname:g" psad.conf || die "fix_psad_conf failed"
	sed -i "s:/bin/mknod:/usr/bin/mknod:g" psad.conf || die "fix_psad_conf failed"
}
