# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.5_rc2.ebuild,v 1.2 2007/01/05 11:22:21 opfer Exp $

inherit eutils

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
SRC_URI="http://www.imapproxy.org/downloads/${P/_/}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="kerberos ssl tcpd"

DEPEND=">=sys-libs/ncurses-5.1
	kerberos? ( virtual/krb5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

S="${WORKDIR}/${P/_/}"
src_unpack() {
	unpack ${A} && cd "${S}"
	epatch "${FILESDIR}"/1.2.4-include-fix.patch
	sed -i -e 's:in\.imapproxyd:imapproxyd:g'  \
		README Makefile.in include/imapproxy.h || die "sed failed"
}

src_compile() {
	econf \
		$(use_with kerberos krb5) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	dosbin bin/imapproxyd bin/pimpstat || die "dosbin failed"

	insinto /etc
	doins scripts/imapproxy.conf || die "doins failed"

	newinitd "${FILESDIR}"/imapproxy.rc6 imapproxy || die "initd failed"

	dodoc ChangeLog README README.known_issues README.ssl
}
