# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/easyedit/easyedit-1.4.6.ebuild,v 1.17 2007/03/11 15:33:09 hattya Exp $

IUSE=""

MY_P=ee-${PV}

DESCRIPTION="An easy to use text editor. Intended to be usable with little or no instruction."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${MY_P}.src.tgz"

LICENSE="Artistic"
KEYWORDS="~amd64 ia64 mips ppc ppc-macos ppc64 sparc x86"
SLOT="0"

DEPEND=">=sys-libs/ncurses-5.0"

PROVIDE="virtual/editor"

src_compile() {

	emake -j1 || die

}

src_install() {

	dobin ee
	doman ee.1
	dodoc README.ee Changes ee.i18n.guide ee.msg

}
