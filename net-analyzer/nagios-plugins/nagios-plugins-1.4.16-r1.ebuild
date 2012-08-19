# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-plugins/nagios-plugins-1.4.16-r1.ebuild,v 1.2 2012/08/19 18:57:13 flameeyes Exp $

EAPI=4

PATCHSET=2

inherit autotools eutils multilib user

DESCRIPTION="Nagios $PV plugins - Pack of plugins to make Nagios work properly"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagiosplug/${P}.tar.gz
	http://dev.gentoo.org/~flameeyes/${PN}/${P}-patches-${PATCHSET}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="+ssl samba mysql postgres ldap snmp nagios-dns nagios-ntp nagios-ping nagios-ssh nagios-game ups ipv6 radius +suid jabber gnutls"

DEPEND="ldap? ( >=net-nds/openldap-2.0.25 )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	ssl? (
		!gnutls? ( >=dev-libs/openssl-0.9.6g )
		gnutls? ( net-libs/gnutls )
	)
	radius? ( >=net-dialup/radiusclient-0.3.2 )"

# tests try to ssh into the box itself
RESTRICT="test"

RDEPEND="${DEPEND}
	>=dev-lang/perl-5.6.1-r7
	samba? ( >=net-fs/samba-2.2.5-r1 )
	snmp? ( >=dev-perl/Net-SNMP-4.0.1-r1 )
	mysql? ( dev-perl/DBI
			 dev-perl/DBD-mysql )
	nagios-dns? ( >=net-dns/bind-tools-9.2.2_rc1 )
	nagios-ntp? ( >=net-misc/ntp-4.1.1a )
	nagios-ping? ( >=net-analyzer/fping-2.4_beta2-r1 )
	nagios-ssh? ( >=net-misc/openssh-3.5_p1 )
	ups? ( >=sys-power/nut-1.4 )
	nagios-game? ( >=games-util/qstat-2.6 )
	jabber? ( >=dev-perl/Net-Jabber-2.0 )"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /var/nagios/home nagios
}

src_prepare() {
	epatch "${WORKDIR}"/patches/*.patch

	eautoreconf
}

src_configure() {
	local myconf
	if use ssl; then
		myconf+="
			$(use_with !gnutls openssl /usr)
			$(use_with gnutls gnutls /usr)"
	else
		myconf+=" --without-openssl --without-gnutls"
	fi

	econf \
		$(use_with mysql) \
		$(use_with ipv6) \
		$(use_with ldap) \
		$(use_with radius) \
		$(use_with postgres pgsql /usr) \
		${myconf} \
		--libexecdir=/usr/$(get_libdir)/nagios/plugins \
		--sysconfdir=/etc/nagios
}

src_install() {
	mv "${S}"/contrib/check_compaq_insight.pl "${S}"/contrib/check_compaq_insight.pl.msg
	chmod +x "${S}"/contrib/*.pl

	sed -i -e '1s;#!.*;#!/usr/bin/perl -w;' "${S}"/contrib/*.pl || die "sed failed"
	sed -i -e s#/usr/nagios/libexec#/usr/$(get_libdir)/nagios/plugins#g "${S}"/contrib/*.pl || die "sed failed"
	sed -i -e '30s/use lib utils.pm;/use utils;/' \
		"${S}"/plugins-scripts/check_file_age.pl || die "sed failed"

	dodoc ACKNOWLEDGEMENTS AUTHORS BUGS CODING \
		ChangeLog FAQ NEWS README REQUIREMENTS SUPPORT THANKS

	emake DESTDIR="${D}" install || die "make install failed"

	if use mysql || use postgres; then
		dodir /usr/$(get_libdir)/nagios/plugins
		exeinto /usr/$(get_libdir)/nagios/plugins
		doexe "${S}"/contrib/check_nagios_db.pl
	fi

	mv "${S}"/contrib "${D}"/usr/$(get_libdir)/nagios/plugins/contrib

	if ! use jabber; then
		rm "${D}"usr/$(get_libdir)/nagios/plugins/contrib/nagios_sendim.pl \
			|| die "Failed to remove XMPP notification addon"
	fi

	chown -R root:nagios "${D}"/usr/$(get_libdir)/nagios/plugins \
		|| die "Failed chown of ${D}usr/$(get_libdir)/nagios/plugins"

	chmod -R o-rwx "${D}"/usr/$(get_libdir)/nagios/plugins \
		|| die "Failed chmod of ${D}usr/$(get_libdir)/nagios/plugins"

	if use suid ; then

		chmod 04710 "${D}"/usr/$(get_libdir)/nagios/plugins/{check_icmp,check_ide_smart,check_dhcp} \
			|| die "Failed setting the suid bit for various plugins"
	fi

	dosym /usr/$(get_libdir)/nagios/plugins/utils.sh /usr/$(get_libdir)/nagios/plugins/contrib/utils.sh
	dosym /usr/$(get_libdir)/nagios/plugins/utils.pm /usr/$(get_libdir)/nagios/plugins/contrib/utils.pm
}

pkg_postinst() {
	elog "This ebuild has a number of USE flags which determines what nagios is able to monitor."
	elog "Depending on what you want to monitor with nagios, some or all of these USE"
	elog "flags need to be set for nagios to function correctly."
	elog "contrib plugins are installed into /usr/$(get_libdir)/nagios/plugins/contrib"
}
