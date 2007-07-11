# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zynaddsubfx/zynaddsubfx-2.2.1-r2.ebuild,v 1.4 2007/07/11 19:30:24 mr_bones_ Exp $

inherit eutils

MY_P=ZynAddSubFX-${PV}
DESCRIPTION="ZynAddSubFX is an opensource software synthesizer."
HOMEPAGE="http://zynaddsubfx.sourceforge.net/"
SRC_URI="mirror://sourceforge/zynaddsubfx/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"

#IUSE="oss alsa jack mmx"
IUSE="oss alsa jack"

DEPEND=">=x11-libs/fltk-1.1.2
	=sci-libs/fftw-3*
	media-sound/jack-audio-connection-kit
	>=dev-libs/mini-xml-2.2.1"
#	portaudio? ( media-libs/portaudio )"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror ""
		eerror "To be able to build ZynAddSubFx with ALSA support you need"
		eerror "to have built media-libs/alsa-lib with midi USE flag."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_unpack() {
	unpack ${MY_P}.tar.bz2 || die
}

src_compile() {
	local FFTW_VERSION=3
	local ASM_F2I=NO
	local LINUX_MIDIIN=NONE
	local LINUX_AUDIOOUT=NONE

	if use oss ; then
		LINUX_MIDIIN=OSS
		LINUX_AUDIOOUT=OSS
		use jack && LINUX_AUDIOOUT=OSS_AND_JACK
	else
		use jack && LINUX_AUDIOOUT=JACK
	fi

	use alsa && LINUX_MIDIIN=ALSA
#	use portaudio && LINUX_AUDIOOUT=PA
#	use mmx && ASM_F2I=YES

	cd ${S}/src
	make \
		FFTW_VERSION=${FFTW_VERSION} \
		ASM_F2I=${ASM_F2I} \
		LINUX_MIDIIN=${LINUX_MIDIIN} \
		LINUX_AUDIOOUT=${LINUX_AUDIOOUT} \
		|| die "compile failed"
	cd ${S}/ExternalPrograms/Spliter
	./compile.sh
	cd ${S}/ExternalPrograms/Controller
	./compile.sh
}

src_install() {
	dobin ${S}/src/zynaddsubfx
	dobin ${S}/ExternalPrograms/Spliter/spliter
	dobin ${S}/ExternalPrograms/Controller/controller
	dodoc ChangeLog FAQ.txt HISTORY.txt README.txt ZynAddSubFX.lsm bugs.txt

	for i in "Arpeggios" "Bass" "Brass" "Choir and Voice" "Drums" \
			 "Dual" "Fantasy" "Guitar" "Misc" "Noises" "Organ" \
			 "Pads" "Plucked" "Reed and Wind" "Rhodes" "Splited" \
			 "Strings" "Synth" "SynthPiano"
	do
		insinto "/usr/share/${PN}/banks/${i}"
		doins "${S}/banks/${i}/"*
	done

	insinto /usr/share/${PN}/presets
	doins "${S}/presets/"*
	insinto /usr/share/${PN}
	doins "${S}/examples/"*
}
