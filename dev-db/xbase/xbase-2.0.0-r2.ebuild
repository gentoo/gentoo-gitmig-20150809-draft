# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/xbase/xbase-2.0.0-r2.ebuild,v 1.1 2012/06/30 13:41:45 jlec Exp $

EAPI=4

inherit autotools-utils

DESCRIPTION="xbase (i.e. dBase, FoxPro, etc.) compatible C++ class library"
HOMEPAGE="http://www.rekallrevealed.org/"
SRC_URI="http://www.rekallrevealed.org/packages/${P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc static-libs"

RDEPEND=""
DEPEND="${DEPEND}
	sys-devel/automake
	sys-devel/libtool"

PATCHES=(
	"${FILESDIR}"/${P}-gcc43.patch
	"${FILESDIR}"/${P}-gcc47.patch
	"${FILESDIR}"/${P}-fixconfig.patch
	"${FILESDIR}"/${P}-x86_64.patch
	"${FILESDIR}"/${P}-ldflags.patch
)

AUTOTOOLS_IN_SOURCE_BUILD=1

src_compile() {
	autotools-utils_src_compile \
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)"
}

src_install() {
	autotools-utils_src_install
	# media-tv/linuxtv-dvb-apps collision, bug #208596
	mv "${ED}/usr/bin/zap" "${ED}/usr/bin/xbase-zap" || die

	if use doc; then
		dohtml html/*
		insinto /usr/share/doc/${PF}/examples
		doins examples/{*.cpp,examples.ide,makefile.g95}
	fi
}
