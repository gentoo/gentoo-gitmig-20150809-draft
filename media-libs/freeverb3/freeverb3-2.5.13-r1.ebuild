# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/freeverb3/freeverb3-2.5.13-r1.ebuild,v 1.1 2010/12/10 10:02:30 sping Exp $

EAPI=2
inherit eutils autotools versionator

MY_PV=$(replace_version_separator 3 '')

DESCRIPTION="High Quality Reverb and Impulse Response Convolution library including XMMS/Audacious Effect plugins"
HOMEPAGE="http://freeverb3.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audacious jack plugdouble sse sse2 sse3 sse4 3dnow forcefpu"

RDEPEND=">=sci-libs/fftw-3.0.1
	audacious? ( media-sound/audacious
		media-libs/libsndfile )
	jack? ( media-sound/jack-audio-connection-kit
		media-libs/libsndfile )"
DEPEND=${RDEPEND}

S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-respect-disable-sse.patch
	eautoreconf
}

src_configure() {
	# NOTE: SSE1v2 and SSE2 assembly broken in 2.5.13
	econf \
		--enable-release \
		--disable-bmp \
		--disable-pluginit \
		$(use_enable audacious) \
		$(use_enable jack) \
		$(use_enable plugdouble) \
		$(use_enable 3dnow) \
		$(use sse && echo --enable-sse=v1 || echo --disable-sse) \
		--disable-sse2 \
		$(use_enable sse3) \
		$(use_enable sse4) \
		$(use_enable forcefpu) \
		|| die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ChangeLog README || die 'dodoc failed'

	insinto /usr/share/${PN}/samples/IR
	doins samples/IR/*.wav || die
}
