# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura-pdf-poppler/zathura-pdf-poppler-0.1.0.ebuild,v 1.1 2012/03/08 09:19:45 ssuominen Exp $

EAPI=4
inherit toolchain-funcs

DESCRIPTION="PDF plug-in for zathura"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/zathura/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-text/poppler[cairo]
	>=app-text/zathura-0.1.0
	dev-libs/girara:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		CC="$(tc-getCC)"
		LD="$(tc-getLD)"
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
