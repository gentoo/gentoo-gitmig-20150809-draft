# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.0.8.3.ebuild,v 1.3 2011/05/26 14:32:53 xmw Exp $

EAPI=4
inherit savedconfig toolchain-funcs

DESCRIPTION="A highly customizable and functional PDF viewer based on poppler and GTK+"
HOMEPAGE="http://zathura.pwmt.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
#SRC_URI="http://zathura.pwmt.org/attachments/download/31/${P}.tar.gz"

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
}
