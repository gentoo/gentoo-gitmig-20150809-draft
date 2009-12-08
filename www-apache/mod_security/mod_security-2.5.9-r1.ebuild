# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_security/mod_security-2.5.9-r1.ebuild,v 1.5 2009/12/08 19:39:46 nixnut Exp $

inherit apache-module autotools

MY_P=${P/mod_security-/modsecurity-apache_}
MY_P=${MY_P/_rc/-rc}

DESCRIPTION="Web application firewall and Intrusion Detection System for Apache."
HOMEPAGE="http://www.modsecurity.org/"
SRC_URI="http://www.modsecurity.org/download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc ~sparc x86"
IUSE="lua perl"

DEPEND="dev-libs/libxml2
	perl? ( dev-perl/libwww-perl )
	lua? ( >=dev-lang/lua-5.1 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

APACHE2_MOD_FILE="apache2/.libs/${PN}2.so"
APACHE2_MOD_CONF="2.1.2/99_mod_security"
APACHE2_MOD_DEFINE="SECURITY"

need_apache2

src_unpack() {
	unpack ${A}

	cd "${S}"/apache2

	epatch "${FILESDIR}"/${P}-broken-autotools.patch
	epatch "${FILESDIR}"/${P}-as-needed.patch

	eautoreconf
}

src_compile() {
	cd apache2

	econf --with-apxs="${APXS}" \
		--without-curl \
		$(use_with lua) \
		|| die "econf failed"

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
	make test || die
}

src_install() {
	apache-module_src_install

	# install rules updater only if perl is enabled (optionally)
	if use perl; then
		newsbin tools/rules-updater.pl modsec-rules-updater || die
	fi

	# install documentation
	dodoc CHANGES || die
	newdoc rules/CHANGELOG CHANGES.crs || die
	newdoc rules/README README.crs || die
	dohtml -r doc/* || die

	# Prepare the core ruleset
	cd "${S}"/rules/

	sed -i -e 's:logs/:/var/log/apache2/:g' *.conf || die

	insinto ${APACHE_MODULES_CONFDIR}/mod_security/
	for i in *.conf; do
		newins ${i} ${i/modsecurity_crs_/} || die
	done
}

pkg_postinst() {
	elog "Please note that the core rule set distributed with mod_security is quite"
	elog "draconic. If you're using this on a blog, a forum or another user-submitted"
	elog "web application where you might talk about standard Unix paths (such as /etc"
	elog "or /bin), you might want to disable at least rules 950005 and 950907"
	elog "(command injection) if you're sure it might not be a security risk."
	elog " "
	elog "To do that on the most limited case you might want to use something like"
	elog "the following code (this comes from a Typo weblog instance):"
	elog " "
	elog "	<Location /comments>"
	elog "	SecRuleRemoveById 950005 950907"
	elog "	</Location>"
	elog " "
}
