# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_security/mod_security-2.5.12-r1.ebuild,v 1.2 2010/10/13 20:26:18 maekke Exp $

EAPI=2

inherit apache-module autotools

MY_P=${P/mod_security-/modsecurity-apache_}
MY_P=${MY_P/_rc/-rc}

DESCRIPTION="Web application firewall and Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lua"

DEPEND="dev-libs/libxml2
	lua? ( >=dev-lang/lua-5.1 )
	www-servers/apache[apache2_modules_unique_id]"
RDEPEND="${DEPEND}"
PDEPEND="www-apache/modsecurity-crs"

S="${WORKDIR}/${MY_P}"

APACHE2_MOD_FILE="apache2/.libs/${PN}2.so"
APACHE2_MOD_CONF="2.5.10/99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

need_apache2

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.5.10-as-needed.patch

	cd apache2
	eautoreconf
}

src_configure() {
	cd apache2

	econf --with-apxs="${APXS}" \
		--without-curl \
		$(use_with lua) \
		|| die "econf failed"
}

src_compile() {
	cd apache2

	APXS_FLAGS=
	for flag in ${CFLAGS}; do
		APXS_FLAGS="${APXS_FLAGS} -Wc,${flag}"
	done

	# Yes we need to prefix it _twice_
	for flag in ${LDFLAGS}; do
		APXS_FLAGS="${APXS_FLAGS} -Wl,${flag}"
	done

	emake \
		APXS_CFLAGS="${CFLAGS}" \
		APXS_LDFLAGS="${LDFLAGS}" \
		APXS_EXTRA_CFLAGS="${APXS_FLAGS}" \
		|| die "emake failed"
}

src_test() {
	cd apache2
	emake test || die
}

src_install() {
	apache-module_src_install

	# install documentation
	dodoc CHANGES || die
	dohtml -r doc/* || die

	keepdir /var/cache/mod_security || die
	fowners apache:apache /var/cache/mod_security || die
	fperms 0770 /var/cache/mod_security || die
}
