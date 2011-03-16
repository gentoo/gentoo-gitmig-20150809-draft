# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.4.4.ebuild,v 1.5 2011/03/16 20:04:58 xarthisius Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE="debug ssl"

RDEPEND=">=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

src_compile() {
	append-flags -D_GNU_SOURCE
	emake \
		CC="$(tc-getCC)" \
		$(use ssl && echo SSL=yes || echo SSL=no) \
		$(use debug && echo DEBUG=yes || echo DEBUG=no) \
			|| die "emake failed"
}

src_install() {
	dobin httping || die "dobin failed"
	doman httping.1 || die "doman failed"
	dodoc readme.txt || die "dodoc failed"
}
