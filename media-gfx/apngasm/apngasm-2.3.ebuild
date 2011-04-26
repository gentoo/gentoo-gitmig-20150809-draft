# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/apngasm/apngasm-2.3.ebuild,v 1.1 2011/04/26 17:35:50 vapier Exp $

EAPI="3"

inherit toolchain-funcs

DESCRIPTION="create an APNG from multiple PNG files"
HOMEPAGE="http://sourceforge.net/projects/apngasm/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}-src.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng[apng]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-arch/unzip"

S=${WORKDIR}

src_compile() {
	emake CC="$(tc-getCC)" LDLIBS="$($(tc-getPKG_CONFIG) --libs libpng)" ${PN} || die
}

src_install() {
	dobin ${PN} || die
	dodoc readme.txt
}
