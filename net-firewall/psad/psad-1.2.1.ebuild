# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/psad/psad-1.2.1.ebuild,v 1.1 2003/09/17 23:32:46 seemant Exp $

inherit eutils
inherit perl-module

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Port Scannning Attack Detection daemon"
SRC_URI="http://www.cipherdyne.org/psad/download/psad-1.2.1.tar.gz"
HOMEPAGE="http://www.cipherdyne.org/psad"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc ~hppa ~mips ~arm"

DEPEND="${DEPEND}
	dev-lang/perl"

RDEPEND="virtual/logger
	dev-perl/Unix-Syslog
	dev-perl/Date-Calc
	net-mail/mailx
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
	emake || die

	cd ${S}
	# We'll use the C binaries until we see them break
	emake || die
}

src_install() {
	keepdir /var/lib/psad /var/log/psad /var/run/psad /var/lock/subsys/${PN}
	dodir /etc/psad
	cd ${S}/Psad
	perl-module_src_install

	cd ${S}/Net-IPv4Addr
	perl-module_src_install
	
	cd ${S}/IPTables/Parse
	perl-module_src_install

	cd ${S}/whois
	# Makefile seems borken, do install by hand...
	insinto /usr
	newbin whois whois_psad
	newman whois.1 whois_psad.1

	cd ${S}
	insinto /usr
	dosbin diskmond kmsgsd psad psadwatchd
	dobin pscan

	cd ${S}
	insinto /etc/psad
	doins *.conf

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
	einfo "Several programs in the PSAD package are in the process of being"
	einfo "converted to compiled C from PERL. If you have any problems,"
	einfo "please notify the PSAD maintainers. Please do not take PSAD"
	einfo "issues to the Bastille-Linux team." 
	echo
	ewarn "Please be sure to edit /etc/psad/psad.conf to reflect your"
	ewarn "system's configuration or it may not work correctly or start up."
}
