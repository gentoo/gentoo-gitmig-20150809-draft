# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.1.0.ebuild,v 1.3 2012/03/08 14:43:57 ssuominen Exp $

EAPI=4
inherit multilib toolchain-funcs

DESCRIPTION="A highly customizable and functional document viewer"
HOMEPAGE="http://pwmt.org/projects/zathura/"
SRC_URI="http://pwmt.org/projects/${PN}/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/girara:2"
DEPEND="${RDEPEND}
	dev-python/docutils
	dev-util/pkgconfig"

pkg_setup() {
	myzathuraconf=(
		ZATHURA_GTK_VERSION=2
		PLUGINDIR='${PREFIX}'/$(get_libdir)/${PN}
		CC="$(tc-getCC)"
		SFLAGS=""
		VERBOSE=1
		DESTDIR="${D}"
		)
}

src_prepare() {
	# http://bt.pwmt.org/view.php?id=140
	# http://bt.pwmt.org/view.php?id=141
	sed -i \
		-e "s:lib/pkg:$(get_libdir)/pkg:" \
		-e 's:rst2man:&.py:' \
		Makefile || die
}

src_compile() {
	emake "${myzathuraconf[@]}"
}

src_install() {
	emake "${myzathuraconf[@]}" install
	dodoc AUTHORS
}
