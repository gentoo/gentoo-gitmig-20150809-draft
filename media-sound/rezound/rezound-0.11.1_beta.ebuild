# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.11.1_beta.ebuild,v 1.1 2004/11/17 06:30:55 eradicator Exp $

IUSE="alsa oggvorbis jack nls oss portaudio flac soundtouch"

inherit eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="virtual/x11
	=dev-libs/fftw-2*
	>=x11-libs/fox-1.2.4
	>=media-libs/audiofile-0.2.3
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/ladspa-cmt-1.15
	alsa? ( >=media-libs/alsa-lib-1.0 )
	flac? ( >=media-libs/flac-1.1.0 )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( >=media-libs/portaudio-18 )
	soundtouch? ( >=media-libs/libsoundtouch-1.2.1 )"

# optional packages (don't need to be installed during emerge):
#
# >=media-sound/lame-3.92
# app-cdr/cdrdao

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/bison
	sys-devel/flex"

src_compile() {
	local myconf=""

	# enforce minimum defaults
	myconf="${myconf} --enable-ladspa"
	myconf="${myconf} --enable-largefile"
	myconf="${myconf} --enable-internal-sample-type=float"

	# enable/disable depending on USE flags
	myconf="${myconf} `use_enable nls`"
	myconf="${myconf} `use_enable alsa`"
	myconf="${myconf} `use_enable oss`"
	myconf="${myconf} `use_enable jack`"
	myconf="${myconf} `use_enable portaudio`"

	# following features can't be disabled if already installed:
	# -> flac, oggvorbis, soundtouch

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	# remove wrong doc directory
	rm -rf ${D}/usr/doc/${PN}
	# install docs manually, but don't install
	# COPYING, since this is obsolete ($LICENCE is enough)
	dodoc ABOUT-NLS docs/{AUTHORS,*INSTALL,NEWS,README*,TODO_FOR_USERS_TO_READ,*.txt}
	docinto code
	dodoc docs/code/*
}

