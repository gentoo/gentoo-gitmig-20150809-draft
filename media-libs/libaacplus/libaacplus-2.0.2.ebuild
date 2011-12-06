# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libaacplus/libaacplus-2.0.2.ebuild,v 1.2 2011/12/06 20:27:45 jer Exp $

EAPI=4

inherit autotools

# This file cannot be mirrored.
# See the notes at http://tipok.org.ua/node/17
# The .tar.gz, ie the wrapper library, is lgpl though.
TGPPDIST=26410-800.zip

DESCRIPTION="HE-AAC+ v2 library, based on the reference implementation"
HOMEPAGE="http://tipok.org.ua/node/17"
SRC_URI="http://dev.gentoo.org/~aballier/${P}.tar.gz
	http://tipok.ath.cx/downloads/media/aac+/libaacplus/${P}.tar.gz
	http://217.20.164.161/~tipok/aacplus/${P}.tar.gz
	http://www.3gpp.org/ftp/Specs/archive/26_series/26.410/${TGPPDIST}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa"
IUSE="bindist fftw static-libs"
RESTRICT="mirror"
REQUIRED_USE="!bindist"

RDEPEND="!media-sound/aacplusenc
	fftw? ( sci-libs/fftw:3.0 )"
DEPEND="${RDEPEND}
	app-arch/unzip
	dev-util/pkgconfig"

src_unpack() {
	unpack ${P}.tar.gz
}

src_prepare() {
	eautoreconf
	cp "${DISTDIR}/${TGPPDIST}" "${S}/src/" || die
}

src_configure() {
	econf $(use_with fftw fftw3) \
		$(use_enable static-libs static)
}

src_compile() {
	emake -j1
}

src_install() {
	default
	find "${D}" -name '*.la' -delete
}
