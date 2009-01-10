# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.39.ebuild,v 1.6 2009/01/10 19:15:16 maekke Exp $

inherit eutils

MY_P="${P}-source"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"
DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="portaudio pulseaudio"
DEPEND="portaudio? ( >=media-libs/portaudio-18.1-r5 )
	pulseaudio? ( media-sound/pulseaudio )
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

get_audio() {
	local MY_AUDIO

	MY_AUDIO=none
	if use portaudio; then
		MY_AUDIO=portaudio
	elif use pulseaudio; then
		MY_AUDIO=pulseaudio
	fi
	echo ${MY_AUDIO}
}

pkg_setup() {
	if ! use portaudio && ! use pulseaudio; then
		ewarn
		ewarn Since portaudio and pulseaudio are not in your use flags,
		ewarn espeak will only bbe able to create wav files.
		ewarn If this is not what you want, press ctrl-c and put either
		ewarn portaudio or pulseaudio in your use flags.
		ebeep
		epause 10
	elif use portaudio && use pulseaudio; then
		die "You must choose either portaudio or pulseaudio, but not both."
	fi
}

src_unpack() {
	unpack ${A}

	# portaudio.h is by default the same as portaudio18.h, but use the version
	# 19 API if available
	if use portaudio; then
		if has_version "=media-libs/portaudio-19*" ; then
			mv -f "${S}/src/portaudio19.h" "${S}/src/portaudio.h"
		fi
	fi
}

src_compile() {
	cd src
	emake AUDIO="$(get_audio)" CXXFLAGS="${CXXFLAGS}" all || die "Compilation failed"

	einfo "Fixing byte order of phoneme data files"
	cd "${S}/platforms/big_endian"
	make
	./espeak-phoneme-data "${S}/espeak-data"
	cp -f phondata phonindex phontab "${S}/espeak-data"
}

src_install() {
	cd src
	make DESTDIR="${D}" LIBDIR="/usr/$(get_libdir)" AUDIO="$(get_audio)" install || die "Installation failed"

	cd ..
	insinto /usr/share/espeak-data
	doins -r dictsource
	dodoc ChangeLog ReadMe
	dohtml -r docs/*
}
