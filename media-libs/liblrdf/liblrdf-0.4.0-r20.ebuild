# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/liblrdf/liblrdf-0.4.0-r20.ebuild,v 1.4 2011/09/20 13:17:52 chainsaw Exp $

EAPI=4
inherit autotools eutils

DESCRIPTION="A library for the manipulation of RDF file in LADSPA plugins"
HOMEPAGE="http://lrdf.sourceforge.net/"
SRC_URI="mirror://sourceforge/lrdf/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="static-libs"

RDEPEND="media-libs/raptor:2
	>=media-libs/ladspa-sdk-1.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS ChangeLog README )

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-dontbuild-tests.patch \
		"${FILESDIR}"/${P}-raptor2{,-pkgconfig}.patch \
		"${FILESDIR}"/${P}-rename_clashing_md5_symbols.patch

	eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}

src_install() {
	default
	rm -f "${ED}"usr/lib*/liblrdf.la
}
