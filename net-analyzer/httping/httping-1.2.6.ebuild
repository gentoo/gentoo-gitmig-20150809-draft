# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/httping/httping-1.2.6.ebuild,v 1.4 2008/08/27 12:03:16 gentoofan23 Exp $

inherit toolchain-funcs

DESCRIPTION="http protocol ping-like program"
HOMEPAGE="http://www.vanheusden.com/httping/"
SRC_URI="http://www.vanheusden.com/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ~ppc ppc64 ~sparc x86"
IUSE="ssl"

DEPEND=">=sys-libs/ncurses-5
	ssl? ( dev-libs/openssl )"

src_compile() {
	local makefile
	use ssl || makefile="-f Makefile.nossl"
	emake CC="$(tc-getCC)" ${makefile} || die "emake failed"
}

src_install() {
	dobin httping || die "dobin failed"
	doman httping.1 || die "doman failed"
	dodoc readme.txt || die "dodoc failed"
}
