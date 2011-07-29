# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-misc/apertium/apertium-3.2.0.ebuild,v 1.1 2011/07/29 06:13:10 bicatali Exp $

EAPI=4
inherit eutils autotools

DESCRIPTION="Shallow-transfer machine Translation engine and toolbox"
HOMEPAGE="http://apertium.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="static-libs"

RDEPEND="virtual/libiconv
	dev-libs/libxslt
	dev-libs/libpcre[cxx]
	>=sci-misc/lttoolbox-3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-flags.patch
	epatch "${FILESDIR}"/${PV}-datadir.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_compile() {
	# nasty to fix, be my guest, see apertium/Makefile.am
	emake -j1
}
