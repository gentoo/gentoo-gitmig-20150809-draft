# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.4.ebuild,v 1.1 2005/02/15 12:03:12 dragonheart Exp $

inherit eutils

DESCRIPTION="Nagios $PV plugins - Pack of plugins to make Nagios work properly"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagiosplug/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE="ssl samba mysql postgres ldap snmp nagios-dns nagios-ntp nagios-ping nagios-ssh nagios-game ups ipv6"

# radius - awaiting keywods

DEPEND="ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.52-r1 )
	postgres? ( >=dev-db/postgresql-7.2 )
	ssl? ( >=dev-libs/openssl-0.9.6g )"

# awaiting keywords	radius? ( >=net-dialup/radiusclient-0.3.2 )

# test broken anyway	test? ( >=dev-perl/Cache-Cache-1.03 )"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1-r7
	samba? ( >=net-fs/samba-2.2.5-r1 )
	snmp? (
		>=dev-perl/Net-SNMP-4.0.1-r1
		>=net-analyzer/net-snmp-5.0.6
	)
	nagios-dns? ( >=net-dns/bind-tools-9.2.2_rc1 )
	nagios-ntp? ( >=net-misc/ntp-4.1.1a )
	nagios-ping? ( >=net-analyzer/fping-2.4_beta2-r1 )
	nagios-ssh? ( >=net-misc/openssh-3.5_p1 )
	ups? ( >=www-apps/nut-1.4 )
	!sparc? ( nagios-game? ( >=games-util/qstat-2.6 ) )"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_compile() {
	# awaiting keywords on radius dependancy
	#if ! use radius; then
	#	epatch ${FILESDIR}/nagios-plugins-noradius-1.4.patch
	#fi

	./configure \
		`use_with mysql` \
		`use_with postgress` \
		`use with ssl openssl` \
		`use with ipv6` \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--with-nagios-user=nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	mv ${S}/contrib/check_compaq_insight.pl ${S}/contrib/check_compaq_insight.pl.msg
	chmod +x ${S}/contrib/*.pl

	sed -i -e '1s;#!.*;#!/usr/bin/perl -w;' ${S}/contrib/*.pl
	sed -i -e '30s/use lib utils.pm;/use utils;/' ${S}/contrib/check_file_age.pl

	dodoc ABOUT-NLS ACKNOWLEDGEMENTS AUTHORS BUGS CHANGES CODING COPYING
	Changelog FAQ INSTALL LEGAL NEWS README REQUIREMENTS SUPPORT
	make DESTDIR=${D} install || die

	if use mysql || use postgres; then
		dodir /usr/nagios/libexec
		exeinto /usr/nagios/libexec
		doexe ${S}/contrib/check_nagios_db.pl
	fi

	dodir /usr/nagios/libexec/
	mv ${S}/contrib ${D}/usr/nagios/libexec/contrib

	chown -R nagios:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}/usr/nagios/libexec"
}

pkg_postinst() {
	einfo "This ebuild has a number of USE flags which determines what nagios isable to monitor."
	einfo "Depending on what you want to monitor with nagios, some or all of these USE"
	einfo "flags need to be set for nagios to function correctly."
	echo ""
	einfo "contrib plugins are installed into /usr/nagios/libexec/contrib"
}

src_test() {
	einfo "test broken"
}
