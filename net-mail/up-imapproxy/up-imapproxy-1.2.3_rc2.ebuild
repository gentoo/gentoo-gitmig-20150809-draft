# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.3_rc2.ebuild,v 1.2 2004/11/14 18:40:41 tester Exp $

inherit versionator

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
MY_P="${PN}-$(replace_version_separator 3 '' ${PV})"
SRC_URI="http://www.imapproxy.org/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE="kerberos ssl tcpd"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.1
	kerberos? ( virtual/krb5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"


S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A} && cd ${S}
	sed -e 's:in\.imapproxyd:imapproxyd:g' -i README \
		-i Makefile.in -i include/imapproxy.h || die "sed failed"
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
	dosbin bin/imapproxyd bin/pimpstat

	insinto /etc
	doins scripts/imapproxy.conf

	newinitd ${FILESDIR}/imapproxy.rc6 imapproxy

	dodoc ChangeLog README README.known_issues README.ssl
}
