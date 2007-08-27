# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.25.ebuild,v 1.4 2007/08/27 16:57:00 dmwaters Exp $

inherit eutils

MY_P="${P}-source"

DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~sparc ~x86"
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
}

src_compile() {
	cd ${S}/src
	emake CXXFLAGS="${CXXFLAGS}" || die "Compilation failed"

	einfo "Fixing byte order of phoneme data files"
	cd ${S}/big_endian
	make
	./espeak-phoneme-data "${S}/espeak-data"
	cp -f phondata phonindex phontab "${S}/espeak-data"

	einfo "Compiling dict files"
	cd "${S}/dictsource"
	export HOME="${S}"
	local lang
	for l in *_rules; do
		lang=${l/_rules/}
		${S}/src/speak --compile=$lang
	done
}

src_install() {
	cd ${S}/src
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" install || die "Installation failed"

	cd "${S}"
	dodoc ChangeLog ReadMe
	dohtml -r docs/*
}
