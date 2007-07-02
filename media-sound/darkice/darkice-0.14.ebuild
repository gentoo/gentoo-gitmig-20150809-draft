# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/darkice/darkice-0.14.ebuild,v 1.14 2007/07/02 15:14:10 peper Exp $

IUSE="encode vorbis alsa"

DESCRIPTION="IceCast live streamer delivering Ogg and mp3 streams simultaneously to multiple hosts."
HOMEPAGE="http://darkice.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="mirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ~ppc sparc x86"

DEPEND="encode?	( >=media-sound/lame-1.89 )
	vorbis? ( >=media-libs/libvorbis-1.0 )
	alsa? ( >=media-libs/alsa-lib-1.0.0 )"

src_compile() {
	if ! use encode && ! use vorbis
	then

		eerror "You need support for mp3 or Ogg Vorbis enconding for this"
		eerror "package. Please merge again with at least one of the "
		eerror "\`encode' and \`vorbis' USE flags enabled:"
		eerror
		eerror "  # USE=\"encode\" emerge darkice"
		eerror "  # USE=\"vorbis\" emerge darkice"
		die "Won't build without support for lame nor vorbis"
	fi

	econf `use_with alsa` \
	      `use_with encode lame` \
	      `use_with vorbis vorbis` || die

	emake || die "Compilation failed"
}

src_install() {
	einstall darkicedocdir=${D}/usr/share/doc/${PF} || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
