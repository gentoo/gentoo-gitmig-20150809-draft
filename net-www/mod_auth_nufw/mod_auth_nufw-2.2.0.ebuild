# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_nufw/mod_auth_nufw-2.2.0.ebuild,v 1.5 2007/01/28 19:09:57 chtekk Exp $

inherit eutils apache-module autotools

KEYWORDS="~x86"

DESCRIPTION="A NuFW authentication module for Apache."
HOMEPAGE="http://www.inl.fr/mod-auth-nufw.html"
SRC_URI="http://software.inl.fr/releases/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="ldap mysql postgres"

DEPEND="=dev-libs/apr-0*
		ldap? ( net-nds/openldap )
		mysql? ( virtual/mysql )
		postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="mod_auth_nufw.so"

APACHE1_MOD_CONF="50_${PN}"
APACHE1_MOD_DEFINE="AUTH_NUFW"

APACHE2_MOD_CONF="50_${PN}"
APACHE2_MOD_DEFINE="AUTH_NUFW"

DOCFILES="doc/mod_auth_nufw.html"

need_apache

pkg_setup() {
	local cnt=0
	use mysql && cnt="$((${cnt} + 1))"
	use postgres && cnt="$((${cnt} + 1))"
	if [[ "${cnt}" -ne 1 ]] ; then
		eerror "You have set ${P} to use multiple SQL engines."
		eerror "I don't know which to use!"
		eerror "You can use /etc/portage/package.use to	set per-package USE flags."
		eerror "Set it so only one SQL engine type, mysql or postgres, is enabled."
		die "Please set only one SQL engine type!"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-configure_in.patch"
}

src_compile() {
	cd "${S}"

	local apx
	if [[ ${APACHE_VERSION} -eq '1' ]] ; then
		apx=${APXS1}
	else
		apx=${APXS2}
	fi

	APR_INCLUDE="-I`apr-config --includedir`"

	eautoreconf
	econf \
		$(use_with apache2 apache20) \
		$(use_with ldap ldap-uids) \
		$(use_with mysql) \
		--with-apxs=${apx} \
		CPPFLAGS="${APR_INCLUDE} ${CPPFLAGS}" \
		|| die "econf failed"
	emake || die "emake failed"
}
