# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/cyrus-imspd/cyrus-imspd-1.8-r1.ebuild,v 1.2 2010/04/19 10:58:08 flameeyes Exp $

inherit eutils ssl-cert

DESCRIPTION="Internet Message Support Protocol (IMSP) server."
HOMEPAGE="http://asg.web.cmu.edu/cyrus/"
SRC_URI="ftp://ftp.andrew.cmu.edu/pub/cyrus-mail/${PN}-v${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="kerberos ldap ssl"

DEPEND=">=sys-libs/db-3.2
	>=dev-libs/cyrus-sasl-2.1.3
	>=dev-libs/cyrus-imap-dev-2.1.14
	kerberos? ( virtual/krb5 )
	ldap? ( >=net-nds/openldap-2.0 )
	ssl? ( >=net-misc/stunnel-4 )"

S="${WORKDIR}/${PN}-v${PV}"

src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"

	# Cyrus 2.2.x has an extra library.
	if has_version '>=dev-libs/cyrus-imap-dev-2.2'; then
		sed -i -e "s:-lcyrus:-lcyrus -lcyrus_min:" \
			"${S}/imsp/Makefile.in" \
			"${S}/cmulocal/libcyrus.m4" || die "sed failed"
	fi
}

src_compile() {
	econf \
		$(use_with ldap) \
		$(use_enable kerberos gssapi) \
		--without-krb \
		--with-auth=unix

	# Fix some malloc definitions
	sed -i -e \
		's~extern char \*malloc()~extern void *malloc()~g' imsp/*.c

	emake || die "compile problem"
}

src_install() {
	newsbin imsp/cyrus-imspd imspd || die

	newinitd "${FILESDIR}/imspd.rc6" imspd || die
	newconfd "${FILESDIR}/imspd.conf" imspd || die

	keepdir /var/imsp{,/user}

	if use ssl ; then
		insinto /etc/stunnel
		newins "${FILESDIR}/stunnel.conf" imspd.conf || die
	fi
	dodoc README imsp/options.sample notes/* || die
}

pkg_postinst() {
	if use ssl ; then
		sed -i -e "s:#IMSPD_USE_SSL:IMSPD_USE_SSL:" "${ROOT:-/}"etc/conf.d/imsp
		SSL_ORGANIZATION="${SSL_ORGANIZATION:-Cyrus IMSP Server}"
		install_cert /etc/ssl/imspd/server
	fi
}
