# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.22.ebuild,v 1.3 2007/05/06 17:40:43 dertobi123 Exp $

inherit eutils

MY_P="${P}-source"

DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip
	mirror://gentoo/${PN}-utils-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/portaudio-18.1-r5
	app-arch/unzip"

S=${WORKDIR}/${MY_P}


src_unpack() {
	unpack ${A}
	cd "${S}"

	# portaudio.h is by default the same as portaudio18.h, but use the version
	# 19 API if available
	if has_version "=media-libs/portaudio-19*" ; then
		mv -f "${S}/src/portaudio19.h" "${S}/src/portaudio.h"
	fi

	# Apply patch to support big-endian processors
	epatch "${FILESDIR}/${PN}-1.20-big-endian.patch"

	# Apply patch for ppc64 segfault
	epatch "${FILESDIR}/${PN}-1.20-ppc64-segfault.patch"

	# Let's not fail in make install
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	cd src
	emake CXXFLAGS="${CXXFLAGS}" || die "Compilation failed"

	einfo "Fixing byte order of phoneme data files"
	cd "${WORKDIR}/${PN}-utils-${PV}"
	make
	./espeak-phoneme-data "${S}/espeak-data"
	cp -f phondata phonindex phontab "${S}/espeak-data"

	einfo "Compiling dict files"
	cd "${S}/dictsource"
	export HOME="${S}"
	local lang
	for l in *_rules; do
		lang=${l/_rules/}
		../src/speak --compile=$lang
	done
}

src_install() {
	cd src
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die "Installation failed"

	cd "${S}"
	dodoc ChangeLog ReadMe
	dohtml -r docs/*
}
