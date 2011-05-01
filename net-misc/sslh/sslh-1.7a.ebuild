# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/sslh/sslh-1.7a.ebuild,v 1.2 2011/05/01 21:59:28 vapier Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="SSLH lets one accept both HTTPS and SSH connections on the same port"
HOMEPAGE="http://www.rutschle.net/tech/sslh.shtml"
SRC_URI="http://www.rutschle.net/tech/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="tcpd"

RDEPEND="net-libs/libnet
	tcpd? ( sys-apps/tcp-wrappers )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_prepare() {
	sed -i \
		-e '/strip sslh/d' \
		-e '/^LIBS=/s:$: $(LDFLAGS):' \
		-e '/^CFLAGS=/{s:=:+=:;s:$: $(CPPFLAGS):}' \
		Makefile || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		USELIBWRAP=$(usev tcpd) \
		|| die
}

src_install() {
	dobin sslh || die
	doman sslh.8.gz || die
	dodoc ChangeLog README

	newinitd "${FILESDIR}"/sslh.init.d sslh
	newconfd "${FILESDIR}"/sslh.conf.d sslh
}
