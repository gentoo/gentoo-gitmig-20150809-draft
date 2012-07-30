# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/openal/openal-1.14.ebuild,v 1.1 2012/07/30 20:10:00 ssuominen Exp $

EAPI=3
inherit cmake-utils

MY_P=${PN}-soft-${PV}

DESCRIPTION="A software implementation of the OpenAL 3D audio API"
HOMEPAGE="http://kcat.strangesoft.net/openal.html"
SRC_URI="http://kcat.strangesoft.net/openal-releases/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux"
IUSE="alsa alstream coreaudio debug oss portaudio pulseaudio"

RDEPEND="alsa? ( media-libs/alsa-lib )
	alstream? ( virtual/ffmpeg )
	portaudio? ( >=media-libs/portaudio-19_pre )
	pulseaudio? ( media-sound/pulseaudio )"
DEPEND="${RDEPEND}
	oss? ( virtual/os-headers )"

S=${WORKDIR}/${MY_P}

DOCS="alsoftrc.sample env-vars.txt hrtf.txt README"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use alstream EXAMPLES)
		$(cmake-utils_use alsa)
		$(cmake-utils_use coreaudio)
		$(cmake-utils_use oss)
		$(cmake-utils_use portaudio)
		$(cmake-utils_use pulseaudio)
		)
	
	cmake-utils_src_configure
}
