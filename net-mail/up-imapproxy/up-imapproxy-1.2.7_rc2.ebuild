# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.7_rc2.ebuild,v 1.1 2009/06/01 06:33:39 ssuominen Exp $

EAPI=2
MY_P=${P/_}

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
SRC_URI="http://www.imapproxy.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="kerberos ssl tcpd"

RDEPEND="sys-libs/ncurses
	kerberos? ( virtual/krb5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	sys-apps/sed"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e 's:in\.imapproxyd:imapproxyd:g' \
		README Makefile.in include/imapproxy.h || die "sed failed"
}

src_configure() {
	econf \
		$(use_with kerberos krb5) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap)
}

src_install() {
	dosbin bin/imapproxyd bin/pimpstat || die "dosbin failed"

	insinto /etc
	doins scripts/imapproxy.conf || die "doins failed"

	newinitd "${FILESDIR}"/imapproxy.rc6 imapproxy || die "newinitd failed"

	dodoc ChangeLog README README.known_issues
	use ssl && dodoc README.ssl
}
