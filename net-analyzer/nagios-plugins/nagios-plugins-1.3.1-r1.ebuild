# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.3.1-r1.ebuild,v 1.7 2004/08/04 22:18:17 squinky86 Exp $

inherit eutils

DESCRIPTION="Nagios $PV plugins - Pack of plugins to make Nagios work properly"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagiosplug/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~amd64"
IUSE="ldap mysql postgres ssl samba snmp nagios-dns nagios-ntp nagios-ping nagios-ssh"

DEPEND="ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( >=dev-db/mysql-3.23.52-r1 )
	postgres? ( >=dev-db/postgresql-7.2 )
	ssl? ( >=dev-libs/openssl-0.9.6g )"

RDEPEND=">=dev-lang/perl-5.6.1-r7
	samba? ( >=net-fs/samba-2.2.5-r1 )
	snmp? (
		>=dev-perl/Net-SNMP-4.0.1-r1
		>=net-analyzer/net-snmp-5.0.6
	)
	nagios-dns? ( >=net-dns/bind-tools-9.2.2_rc1 )
	nagios-ntp? ( >=net-misc/ntp-4.1.1a )
	nagios-ping? ( >=net-analyzer/fping-2.4_beta2-r1 )
	nagios-ssh? ( >=net-misc/openssh-3.5_p1 )"

pkg_preinst() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
	chown -R nagios:nagios ${D}/usr/nagios/libexec || die "Failed Chown of ${D}/usr/nagios/libexec"
}

src_compile() {
	local myconf
	use mysql && myconf="${myconf} --with-mysql" || myconf="${myconf} --without-mysql"
	use postgres && myconf="${myconf} --with-pgsql" || myconf="${myconf} --without-pgsql"
	use ssl && myconf="${myconf} --with-openssl" || myconf="${myconf} --without-openssl"

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--with-nagios-user=nagios \
		--sysconfdir=/etc/nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	make || die
}

src_install() {
	dodoc AUTHORS CODING COPYING ChangeLog FAQ INSTALL LEGALNEWS README REQUIREMENTS ROADMAP Requirements
	make DESTDIR=${D} install || die

	if use mysql || use postgres; then
		dodir /usr/nagios/libexec
		exeinto /usr/nagios/libexec
		doexe ${S}/contrib/check_nagios_db.pl
	fi

	dodir /usr/nagios/libexec/
	mv ${S}/contrib ${D}/usr/nagios/libexec/contrib
}

pkg_postinst() {
	einfo "This ebuild has a number of USE flags which determines what nagios is able to monitor."
	einfo "Depending on what you want to monitor with nagios, some or all of these USE"
	einfo "flags need to be set for nagios to function correctly."
	echo ""
	einfo "contrib plugins are installed into /usr/nagios/libexec/contrib"
}
