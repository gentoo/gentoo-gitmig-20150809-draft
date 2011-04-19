# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.5.1_beta1.ebuild,v 1.1 2011/04/19 22:44:32 jer Exp $

EAPI="2"

inherit flag-o-matic toolchain-funcs

MY_P="${P/_beta1/beta}"

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ssl"

RDEPEND=">=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

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
