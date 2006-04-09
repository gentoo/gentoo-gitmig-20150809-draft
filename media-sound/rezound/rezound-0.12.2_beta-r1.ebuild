# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/rezound/rezound-0.12.2_beta-r1.ebuild,v 1.2 2006/04/09 13:28:12 tcort Exp $

inherit eutils

MY_P="${P/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Sound editor and recorder"
HOMEPAGE="http://rezound.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="16bittmp alsa flac jack nls oss portaudio soundtouch vorbis"

RDEPEND="=sci-libs/fftw-2*
	>=x11-libs/fox-1.2.4
	>=media-libs/audiofile-0.2.3
	>=media-libs/ladspa-sdk-1.12
	>=media-libs/ladspa-cmt-1.15
	alsa? ( >=media-libs/alsa-lib-1.0 )
	flac? ( >=media-libs/flac-1.1.0 )
	jack? ( media-sound/jack-audio-connection-kit )
	portaudio? ( >=media-libs/portaudio-18 )
	soundtouch? ( >=media-libs/libsoundtouch-1.2.1 )
	vorbis? ( media-libs/libvorbis media-libs/libogg )"

# optional packages (don't need to be installed during emerge):
#
# >=media-sound/lame-3.92
# app-cdr/cdrdao

DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/bison
	sys-devel/flex"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}"/rezound-0.12.2_beta-amd64.patch
}

src_compile() {
	# fix compilation errors on ppc, where some
	# of the required functions aren't defined
	test "${ARCH}" = ppc && epatch ${FILESDIR}/undefined-functions.patch

	# following features can't be disabled if already installed:
	# -> flac, oggvorbis, soundtouch
	local sampletype="--enable-internal-sample-type=float"
	use 16bittmp && sampletype="--enable-internal-sample-type=int16"

	econf \
		$(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable nls) \
		$(use_enable oss) \
		$(use_enable portaudio) \
		${sampletype} \
		--enable-ladspa \
		--enable-largefile \
		|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# remove wrong doc directory
	rm -rf "${D}/usr/doc"

	dodoc docs/{AUTHORS,NEWS,README*}
	dodoc docs/{TODO_FOR_USERS_TO_READ,*.txt}
	newdoc README README.rezound

	docinto code
	dodoc docs/code/*
}
