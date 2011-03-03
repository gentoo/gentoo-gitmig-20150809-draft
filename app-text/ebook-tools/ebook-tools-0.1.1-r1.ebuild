# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ebook-tools/ebook-tools-0.1.1-r1.ebuild,v 1.3 2011/03/03 15:17:57 tomka Exp $

inherit cmake-utils multilib

DESCRIPTION="Tools for accessing and converting various ebook file formats."
HOMEPAGE="http://sourceforge.net/projects/ebook-tools"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ia64 ~ppc ~ppc64 x86"
IUSE=""

DEPEND="dev-libs/libxml2
	dev-libs/libzip"
RDEPEND="${DEPEND}
	app-text/convertlit"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/TARGETS epub/ s:lib:$(get_libdir):g" \
		"${S}"/src/libepub/CMakeLists.txt
}

src_install() {
	cmake-utils_src_install
	dodoc INSTALL README TODO
}
