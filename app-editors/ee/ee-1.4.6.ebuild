# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/ee/ee-1.4.6.ebuild,v 1.3 2011/08/13 12:29:33 hattya Exp $

EAPI="4"

inherit toolchain-funcs

DESCRIPTION="An easy to use text editor. Intended to be usable with little or no instruction."
HOMEPAGE="http://mahon.cwx.net/"
SRC_URI="http://mahon.cwx.net/sources/${P}.src.tgz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="!app-editors/ersatz-emacs"
S="${WORKDIR}/easyedit-${PV}"

src_prepare() {
	sed -i \
		-e "s/\tcc /\t\\\\\$(CC) /" \
		-e "/other_cflag/s/ *-s//" \
		create.make
}

src_configure() {
	emake localmake
}

src_compile() {
	emake -f make.local CC="$(tc-getCC)"
}

src_install() {
	dobin ee
	doman ee.1
	dodoc Changes README.ee ee.i18n.guide ee.msg
}
