# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.0.8.5.ebuild,v 1.1 2011/12/05 22:06:01 wired Exp $

EAPI=4
inherit savedconfig toolchain-funcs eutils

DESCRIPTION="A highly customizable and functional PDF viewer based on poppler and GTK+"
HOMEPAGE="http://zathura.pwmt.org/"
SRC_URI="http://pwmt.org/download/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=x11-libs/cairo-1.8.8
	>=dev-libs/glib-2.22.4:2
	>=x11-libs/gtk+-2.18.6:2
	>=app-text/poppler-0.12.3[cairo]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( README )

src_prepare() {
	restore_config config.def.h
}

src_compile() {
	tc-export CC
	emake SFLAGS=""
}

src_install() {
	default
	save_config config.def.h

	doman zathura.1
	domenu zathura.desktop
}
