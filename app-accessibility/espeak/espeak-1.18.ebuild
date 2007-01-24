# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.18.ebuild,v 1.2 2007/01/24 18:52:12 leonardop Exp $

inherit eutils

MY_P="${P}-source"

DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=media-libs/portaudio-18.1-r5
	app-arch/unzip"

S=${WORKDIR}/${MY_P}


src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Fix compilation in 64bit systems (e.g. amd64)
	epatch "${FILESDIR}/${P}-64bits.patch"

	# Fix parallel compilation
	epatch "${FILESDIR}/${P}-parallel.patch"

	# portaudio.h is by default the same as portaudio18.h, but use the version
	# 19 API if available
	if has_version "=media-libs/portaudio-19*" ; then
		mv -f "${S}/src/portaudio19.h" "${S}/src/portaudio.h"
	fi
}

src_compile() {
	cd src
	emake CXXFLAGS="${CXXFLAGS}" || die "Compilation failed"
}

src_install() {
	cd src
	make DESTDIR="${D}" install || die "Installation failed"

	cd "${S}"
	dodoc ChangeLog ReadMe
	dohtml -r docs/*
}
