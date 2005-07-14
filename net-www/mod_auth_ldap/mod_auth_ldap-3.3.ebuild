# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_ldap/mod_auth_ldap-3.3.ebuild,v 1.3 2005/07/14 22:14:49 agriffis Exp $

inherit eutils apache-module

DESCRIPTION="Apache module for LDAP authorization"
HOMEPAGE="http://www.muquit.com/muquit/software/mod_auth_ldap/mod_auth_ldap.html"
SRC_URI="http://www.muquit.com/muquit/software/${PN}/${PN}${PV}.tar.gz"

KEYWORDS="~x86 ~ppc ~sparc"
LICENSE="as-is"
SLOT="0"
IUSE="apache2 berkdb disk-cache gdbm mem-cache"

DEPEND=">=net-nds/openldap-2.0.25"
RDEPEND=""

APACHE1_MOD_CONF="55_${PN}"
APACHE1_MOD_DEFINE="AUTH_LDAP"

APACHE2_MOD_CONF="55_${PN}"
APACHE2_MOD_DEFINE="AUTH_LDAP"

DOCFILES="README *.pdf"

S=${WORKDIR}/${PN}${PV}

need_apache

src_compile() {
	local myconf="--with-apache-dir=/usr --with-ldap-dir=/usr"

	if ! use disk-cache; then
		if use berkdb || use gdbm; then
			ewarn "Enabling disk-cache for berkdb/gdbm support"
		else
			myconf="${myconf} --without-disk-cache"
		fi
	fi

	if use apache2; then
		myconf="${myconf} --with-apache-ver=2 --with-apxs=${APXS2}"
	else
		myconf="${myconf} --with-apache-ver=1 --with-apxs=${APXS1}"
	fi

	myconf="${myconf} `use_with gdbm` `use_with berkdb db` `use_with mem-cache`"

	econf ${myconf} || die "econf failed"

	use mem-cache && emake libghthash.a
	emake || die "emake failed"
}
