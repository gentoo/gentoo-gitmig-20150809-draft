# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/easyedit/easyedit-1.4.6.ebuild,v 1.21 2010/10/19 06:24:01 leio Exp $

inherit toolchain-funcs

IUSE=""

MY_P=ee-${PV}

DESCRIPTION="An easy to use text editor. Intended to be usable with little or no instruction."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${MY_P}.src.tgz"

LICENSE="Artistic"
KEYWORDS="~amd64 ia64 ~mips ppc ppc64 sparc x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5.0"

src_unpack() {

	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/\tcc /\t\\\\\$(CC) /" \
		-e "/other_cflag/s/ *-s//" \
		create.make

}

src_compile() {

	emake -j1 CC="$(tc-getCC)" || die

}

src_install() {

	dobin ee
	doman ee.1
	dodoc README.ee Changes ee.i18n.guide ee.msg

}
