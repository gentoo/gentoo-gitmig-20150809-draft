# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.4.3-r1.ebuild,v 1.3 2006/10/21 22:11:36 tcort Exp $

inherit eutils

DESCRIPTION="Nagios $PV plugins - Pack of plugins to make Nagios work properly"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagiosplug/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ssl samba mysql postgres ldap snmp nagios-dns nagios-ntp nagios-ping
nagios-ssh nagios-game ups ipv6 radius"

DEPEND="ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.52-r1 )
	postgres? ( >=dev-db/postgresql-7.2 )
	ssl? ( >=dev-libs/openssl-0.9.6g )
	radius? ( >=net-dialup/radiusclient-0.3.2 )"

RESTRICT="test"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1-r7
	samba? ( >=net-fs/samba-2.2.5-r1 )
	snmp? ( >=dev-perl/Net-SNMP-4.0.1-r1
			>=net-analyzer/net-snmp-5.0.6
			)
	mysql? ( dev-perl/DBI
			 dev-perl/DBD-mysql )
	nagios-dns? ( >=net-dns/bind-tools-9.2.2_rc1 )
	nagios-ntp? ( >=net-misc/ntp-4.1.1a )
	nagios-ping? ( >=net-analyzer/fping-2.4_beta2-r1 )
	nagios-ssh? ( >=net-misc/openssh-3.5_p1 )
	ups? ( >=sys-power/nut-1.4 )
	!sparc? ( nagios-game? ( >=games-util/qstat-2.6 ) )"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_unpack() {
	unpack ${A}
	if ! use radius; then
		EPATCH_OPTS="-p0 -d ${S}" epatch \
			${FILESDIR}/nagios-plugins-1.4-noradius.patch \
			${FILESDIR}/nagios-plugins-1.4-autoconf-fix.patch
	fi

	# Remove this after 1.4.3 since its been applied upstream
	EPATCH_OPTS="-d ${S}" epatch \
	${FILESDIR}/nagios-plugins-1.4.3-check_disk-fix.patch

	if ! use radius; then
		export WANT_AUTOCONF=2.5
		export WANT_AUTMAKE=1.8
		cd ${S}
		aclocal -I m4 || die "Failed to run aclocal"
		autoconf || die "Failed to run autoconf"
		automake || die "Failed to run automake"
		libtoolize --copy --force
	fi
}

src_compile() {

	econf \
		$(use_with mysql) \
		$(use_with postgres) \
		$(use_with ssl openssl) \
		$(use_with ipv6) \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--with-nagios-user=nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "econf failed"

	# fix problem with additional -
	sed -i -e 's:/bin/ps -axwo:/bin/ps axwo:g' config.h || die "sed failed"

	emake || die "emake failed"
}

src_install() {
	mv ${S}/contrib/check_compaq_insight.pl ${S}/contrib/check_compaq_insight.pl.msg
	chmod +x ${S}/contrib/*.pl

	sed -i -e '1s;#!.*;#!/usr/bin/perl -w;' ${S}/contrib/*.pl || die "sed failed"
	sed -i -e '30s/use lib utils.pm;/use utils;/' \
		${S}/plugins-scripts/check_file_age.pl || die "sed failed"

	dodoc ABOUT-NLS ACKNOWLEDGEMENTS AUTHORS BUGS CHANGES CODING COPYING \
		Changelog FAQ INSTALL LEGAL NEWS README REQUIREMENTS SUPPORT

	make DESTDIR="${D}" install || die "make install failed"

	if use mysql || use postgres; then
		dodir /usr/nagios/libexec
		exeinto /usr/nagios/libexec
		doexe ${S}/contrib/check_nagios_db.pl
	fi

	dodir /usr/nagios/libexec/
	mv ${S}/contrib ${D}/usr/nagios/libexec/contrib

	chown -R nagios:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}usr/nagios/libexec"

	chmod -R o-rwx ${D}/usr/nagios/libexec || "Failed Chmod of ${D}usr/nagios/libexec"
}

pkg_postinst() {
	einfo "This ebuild has a number of USE flags which determines what nagios is able to monitor."
	einfo "Depending on what you want to monitor with nagios, some or all of these USE"
	einfo "flags need to be set for nagios to function correctly."
	echo
	einfo "contrib plugins are installed into /usr/nagios/libexec/contrib"
}

