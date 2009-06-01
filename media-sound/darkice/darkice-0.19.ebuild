# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.19.ebuild,v 1.5 2009/06/01 16:33:07 nixnut Exp $

inherit eutils

DESCRIPTION="IceCast live streamer, delivering ogg and mp3 streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net"
SRC_URI="http://${PN}.tyrell.hu/dist/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ~sparc x86"
IUSE="aac alsa encode jack twolame vorbis"

RDEPEND="encode? ( media-sound/lame )
	vorbis? ( media-libs/libvorbis )
	aac? ( media-libs/faac )
	twolame? ( media-sound/twolame )
	alsa? ( media-libs/alsa-lib )
	jack? ( media-sound/jack-audio-connection-kit )
	!encode? ( !vorbis? ( !aac? ( !twolame? ( media-libs/libvorbis ) ) ) )"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-0.18.1-gcc43.patch
}

src_compile() {
	if ! use encode && ! use vorbis && ! use aac && ! use twolame; then
		ewarn "One of USE flags encode, vorbis, aac, or twolame is required."
		ewarn "Selecting vorbis for you."
		local myconf="--with-vorbis"
	fi

	econf $(use_with aac faac) \
		$(use_with alsa) \
		$(use_with encode lame) \
		$(use_with jack) \
		$(use_with twolame) \
		$(use_with vorbis) \
		${myconf}
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
