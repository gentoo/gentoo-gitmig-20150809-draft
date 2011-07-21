# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-2.0.4.ebuild,v 1.2 2011/07/21 08:37:32 hwoarang Exp $

EAPI=2
inherit eutils multilib flag-o-matic

DESCRIPTION="Inspire IRCd - The Stable, High-Performance Modular IRCd"
HOMEPAGE="http://www.inspircd.org/"
SRC_URI="http://www.inspircd.org/downloads/InspIRCd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="openssl gnutls ipv6 mysql postgres sqlite ldap"

RDEPEND="
	dev-lang/perl
	openssl? ( dev-libs/openssl )
	gnutls? ( net-libs/gnutls )
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )
	sqlite? ( >=dev-db/sqlite-3.0 )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/inspircd"

pkg_setup() {
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
}

src_prepare() {
	# The makefile template defines variables (D and T) used by the
	# ebuild system. Changing them to safe names.
	local makefiletpl="${S}/make/template/main.mk"

	sed -i 's/IFNDEF D/IFNDEF DEBUGLEVEL/' ${makefiletpl} || die "sed failed"
	sed -i 's/IFDEF T/IFDEF TGT/' ${makefiletpl} || die "sed failed"
	sed -i 's/D=0/DEBUGLEVEL=0/' ${makefiletpl} || die "sed failed"
	sed -i 's/\$(D)/\$(DEBUGLEVEL)/' ${makefiletpl} || die "sed failed"
	sed -i 's/\$(T)/\$(TGT)/' ${makefiletpl} || die "sed failed"

	epatch "${FILESDIR}"/${PN}-fix-config.patch
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
			--enable-extras=${extras} || die "configure failed"
	fi

	./configure \
		$(use_enable openssl) \
		$(use_enable gnutls) \
	    --disable-interactive \
		--prefix="/usr/$(get_libdir)/inspircd" \
		--config-dir="/etc/inspircd" \
		--binary-dir="/usr/bin" \
		--module-dir="/usr/$(get_libdir)/inspircd/modules" \
		${dipv6} || die "configure failed"
}

src_compile() {
	append-flags -Iinclude -fPIC
	emake LDFLAGS="${LDFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake INSTUID=inspircd \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/$(get_libdir)/inspircd/inspircd.launcher" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules/" \
		CONPATH="${D}/etc/inspircd" install || die "emake install failed"

	insinto /etc/inspircd/modules
	doins docs/modules/* || die "Installing inspircd modules failed"

	insinto /etc/inspircd/aliases
	doins docs/aliases/* || die "Installing inspircd aliases failed"

	insinto /usr/include/inspircd/
	doins include/* || die "Installing inspircd include files failed"

	diropts -oinspircd -ginspircd
	dodir "/var/run/inspircd" || die "Creating run directory failed"

	newinitd "${FILESDIR}"/${PN}-init.d inspircd \
	         || die "Installing inspircd init script failed"
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
