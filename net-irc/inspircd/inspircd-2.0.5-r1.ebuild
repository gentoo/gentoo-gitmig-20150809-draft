# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-2.0.5-r1.ebuild,v 1.3 2012/03/27 15:00:44 phajdan.jr Exp $

EAPI=4

inherit eutils flag-o-matic multilib

DESCRIPTION="Inspire IRCd - The Stable, High-Performance Modular IRCd"
HOMEPAGE="http://www.inspircd.org/"
SRC_URI="http://www.inspircd.org/downloads/InspIRCd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnutls ipv6 ldap mysql postgres sqlite ssl"

RDEPEND="
	dev-lang/perl
	ssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 -1 ${PN}
}

src_prepare() {
	# Patch the inspircd launcher with the inspircd user
	sed -i -e "s/@UID@/${PN}/" "${S}/make/template/${PN}" || die

	epatch "${FILESDIR}"/${PF}-fix-make-config.patch
}

src_configure() {
	local extras=""
	local dipv6="--disable-ipv6"

	use openssl && extras="${extras}m_ssl_openssl.cpp,"
	use gnutls && extras="${extras}m_ssl_gnutls.cpp,"
	use ldap && extras="${extras}m_ldapauth.cpp,"
	use mysql && extras="${extras}m_mysql.cpp,"
	use postgres && extras="${extras}m_pgsql.cpp,"
	use sqlite && extras="${extras}m_sqlite3.cpp,"

	use ipv6 && dipv6=""

	# allow inspircd to be built by root
	touch .force-root-ok || die

	if [ -n "${extras}" ]; then
		./configure --disable-interactive \
			--enable-extras=${extras} || die
	fi

	./configure \
		--disable-interactive \
		--uid=${INSPIRCDUSER} \
		$(use_enable openssl) \
		$(use_enable gnutls) \
		--prefix="/usr/$(get_libdir)/inspircd" \
		--config-dir="/etc/inspircd" \
		--binary-dir="/usr/bin" \
		--module-dir="/usr/$(get_libdir)/inspircd/modules" \
		${dipv6} || die
}

src_compile() {
	append-cxxflags -Iinclude -fPIC
	emake LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}"
}

src_install() {
	emake INSTUID=inspircd \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/$(get_libdir)/inspircd/inspircd.launcher" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules/" \
		CONPATH="${D}/etc/inspircd" install

	insinto /etc/inspircd/modules
	doins docs/modules/*

	insinto /etc/inspircd/aliases
	doins docs/aliases/*

	insinto /usr/include/inspircd/
	doins include/*

	diropts -oinspircd -ginspircd
	dodir "/var/run/inspircd"

	newinitd "${FILESDIR}/${PF}-init" "${PN}"
	keepdir "/var/log/inspircd/"
}

pkg_postinst() {
	elog "Before starting inspircd the first time you should create"
	elog "the /etc/inspircd/inspircd.conf file."
	elog "You can find example configuration files under /etc/inspircd."
	elog "Read the inspircd.conf.example file carefully before starting "
	elog "the service."
	elog
}
