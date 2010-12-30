# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/zathura/zathura-0.0.8.2.ebuild,v 1.3 2010/12/30 17:42:10 wired Exp $

EAPI=2
inherit savedconfig toolchain-funcs eutils

DESCRIPTION="A highly customizable and functional PDF viewer based on poppler and GTK+"
HOMEPAGE="http://zathura.pwmt.org/"
SRC_URI="http://zathura.pwmt.org/attachments/download/31/${P}.tar.gz"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/cairo-1.8.8
	>=dev-libs/glib-2.22.4:2
	>=x11-libs/gtk+-2.18.6:2
	>=app-text/poppler-0.12.3[cairo]"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	restore_config config.def.h

	# bug #349941
	has_version ">=app-text/poppler-0.15.0" && epatch "${FILESDIR}"/"${PN}"-poppler-0.16.patch
}

src_compile() {
	tc-export CC
	emake SFLAGS="" || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README
	save_config config.def.h
}
