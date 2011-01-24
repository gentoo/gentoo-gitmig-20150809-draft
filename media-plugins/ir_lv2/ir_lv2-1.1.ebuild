# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/ir_lv2/ir_lv2-1.1.ebuild,v 1.1 2011/01/24 11:55:39 aballier Exp $

EAPI=3

inherit base toolchain-funcs flag-o-matic multilib

MY_P="${P/_/.}"
DESCRIPTION="LV2 convolver plugin especially for creating reverb effects"
HOMEPAGE="http://factorial.hu/plugins/lv2/ir"
SRC_URI="http://factorial.hu/system/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="media-libs/zita-convolver
	x11-libs/gtk+:2
	media-libs/libsndfile
	media-libs/libsamplerate"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN/_/.}

PATCHES=( "${FILESDIR}/${P}-makefile.patch" )

src_compile() {
	tc-export CC CXX
	append-cxxflags -fPIC
	emake || die
}

src_install() {
	emake INSTDIR="${D}/usr/$(get_libdir)/lv2/ir.lv2" install || die
	dodoc README ChangeLog || die
}
