# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/up-imapproxy/up-imapproxy-1.2.2.ebuild,v 1.2 2004/10/18 12:24:10 dholm Exp $

DESCRIPTION="Proxy IMAP transactions between an IMAP client and an IMAP server."
HOMEPAGE="http://www.imapproxy.org/"
SRC_URI="http://www.imapproxy.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="kerberos ssl tcpd"

DEPEND="virtual/libc
	>=sys-apps/sed-4
	>=sys-libs/ncurses-5.1
	kerberos? ( virtual/krb5 )
	ssl? ( >=dev-libs/openssl-0.9.6 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

src_unpack() {
	unpack ${A} && cd "${S}"
	sed -e 's:in\.imapproxyd:imapproxyd:g' -i README \
		-i Makefile.in -i include/imapproxy.h || die "sed failed"
}

src_compile() {
	local myconf
	myconf="${myconf} `use_with kerberos krb5`"
	myconf="${myconf} `use_with ssl openssl`"
	myconf="${myconf} `use_with tcpd libwrap`"

	econf ${myconf} || die "econf failed"
	emake || die "compile problem"
}

src_install() {
	dosbin bin/imapproxyd bin/pimpstat

	insinto /etc
	doins scripts/imapproxy.conf

	exeinto /etc/init.d
	newexe "${FILESDIR}/imapproxy.rc6" imapproxy

	dodoc COPYING ChangeLog README README.known_issues README.ssl
}
