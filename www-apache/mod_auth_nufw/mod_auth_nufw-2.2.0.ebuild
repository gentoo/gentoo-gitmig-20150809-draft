# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_auth_nufw/mod_auth_nufw-2.2.0.ebuild,v 1.2 2007/09/21 21:07:07 hollow Exp $

inherit eutils apache-module autotools

DESCRIPTION="A NuFW authentication module for Apache."
HOMEPAGE="http://www.inl.fr/mod-auth-nufw.html"
SRC_URI="http://software.inl.fr/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="ldap mysql postgres"

DEPEND="=dev-libs/apr-0*
	ldap? ( net-nds/openldap )
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql )"
RDEPEND="${DEPEND}"

APACHE2_MOD_FILE="mod_auth_nufw.so"
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
	eautoreconf
}

src_compile() {
	cd "${S}"

	econf --with-apache20 \
		$(use_with ldap ldap-uids) \
		$(use_with mysql) \
		--with-apxs=${APXS2} \
		CPPFLAGS="-I$($(apr_config) --includedir) ${CPPFLAGS}" \
		|| die "econf failed"
	emake || die "emake failed"
}
