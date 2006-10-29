# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/espeak/espeak-1.16.ebuild,v 1.1 2006/10/29 22:37:33 williamh Exp $

MY_P="${P}-source"

DESCRIPTION="Speech synthesizer for English and other languages"
HOMEPAGE="http://espeak.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=media-libs/portaudio-18.1-r5
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}/src"

		# select the version of portaudio to use
	if has_version "=media-libs/portaudio-18*" ; then
		mv -f portaudio18.h portaudio.h
	elif has_version "=media-libs/portaudio-19*" ; then
		mv -f portaudio19.h portaudio.h
	fi
	sed -i -e 's/ -O2//' Makefile
}

src_compile() {
	cd src
	emake || die "Compilation failed."
}

src_install() {
	dobin src/speak || die
	dolib.so src/libespeak.so.* || die
		dosym libespeak.so.1.1.16 /usr/lib/libespeak.so || die
	insinto /usr/include/espeak
	doins src/speak_lib.h

	insinto /usr/share
	doins -r espeak-data || die
	insinto /usr/share/espeak-data
	doins -r dictsource || die

	dodoc ChangeLog ReadMe
	dohtml -r docs/*
}
