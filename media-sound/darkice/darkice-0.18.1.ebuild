# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.18.1.ebuild,v 1.2 2007/11/26 20:41:44 angelos Exp $

inherit eutils

DESCRIPTION="IceCast live streamer, delivering ogg and mp3 streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net"
SRC_URI="http://${PN}.tyrell.hu/dist/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="aac alsa encode jack twolame vorbis"

DEPEND="encode?	( >=media-sound/lame-1.89 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	aac? ( media-libs/faac )
	twolame? ( >=media-sound/twolame-0.3.6 )
	alsa? ( >=media-libs/alsa-lib-1.0.0 )
	jack? ( media-sound/jack-audio-connection-kit )"

src_compile() {
	if ! use encode && ! use vorbis && ! use aac && ! use twolame
	then
		eerror "You need support for mp3, Ogg Vorbis, AAC or MP2 enconding"
		eerror "for this package. Please merge again with at least one of the"
		eerror "\`encode', \`vorbis', \`aac' and \`twolame'  USE flags enabled:"
		eerror
		eerror "  # USE=\"encode\" emerge darkice"
		eerror "  # USE=\"vorbis\" emerge darkice"
		eerror "  # USE=\"aac\" emerge darkice"
		eerror "  # USE=\"twolame\" emerge darkice"
		die "Won't build without support for lame, vorbis, aac nor twolame"
	fi

	econf $(use_with aac faac) \
		$(use_with alsa) \
		$(use_with encode lame) \
		$(use_with jack) \
		$(use_with twolame) \
		$(use_with vorbis) || die "econf failed."
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog FAQ NEWS README TODO
}
