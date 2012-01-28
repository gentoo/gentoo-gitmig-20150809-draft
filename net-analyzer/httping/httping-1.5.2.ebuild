# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.5.2.ebuild,v 1.3 2012/01/28 14:46:18 phajdan.jr Exp $

EAPI="4"

inherit flag-o-matic toolchain-funcs

MY_P="${P/_beta1/beta}"

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc ~ppc64 ~sparc x86"
IUSE="debug ssl"

RDEPEND=">=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}"

S="${WORKDIR}"/${MY_P}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		$(use ssl && echo SSL=yes || echo SSL=no) \
		$(use debug && echo DEBUG=yes || echo DEBUG=no)
}

src_install() {
	dobin httping
	doman httping.1
	dodoc readme.txt
}
