# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ee/ee-1.4.7.ebuild,v 1.1 2011/05/07 15:46:17 hattya Exp $

EAPI="3"

inherit toolchain-funcs

IUSE=""

DESCRIPTION="An easy to use text editor. Intended to be usable with little or no instruction."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${P}.src.tgz"

LICENSE="BSD-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos"
SLOT="0"
S="${WORKDIR}/easyedit-${PV}"

DEPEND=">=sys-libs/ncurses-5.0"

src_prepare() {

	sed -i \
		-e "s/\tcc /\t\\\\\$(CC) /" \
		-e "/other_cflag/s/ *-s//" \
		create.make

}

src_configure() {

	emake localmake
	sed -i -e '/^all/s/ee/curses/' make.local

}

src_compile() {

	emake -f make.local CC="$(tc-getCC)" || die

}

src_install() {

	dobin ee
	doman ee.1
	dodoc README.ee Changes ee.i18n.guide ee.msg

}
