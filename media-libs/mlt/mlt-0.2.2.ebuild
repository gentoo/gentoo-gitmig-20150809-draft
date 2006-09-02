# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt/mlt-0.2.2.ebuild,v 1.3 2006/09/02 23:24:42 lu_zero Exp $

inherit eutils

DESCRIPTION="MLT is an open source multimedia framework, designed and developed
for television broadcasting"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dv xml jack gtk sdl vorbis sox quicktime mmx lame xine lame ogg theora xine"

DEPEND="media-video/ffmpeg
	dv?	( >=media-libs/libdv-0.104 )
	xml?	( >=dev-libs/libxml2-2.5 )
	ogg?	( >=media-libs/libogg-1.1.3 )
	vorbis?	( >=media-libs/libvorbis-1.1.2 )
	sdl?	( >=media-libs/libsdl-1.2.10
		  >=media-libs/sdl-image-1.2.4 )
	>=media-libs/libsamplerate-0.1.2
	jack?	( media-sound/jack-audio-connection-kit
		  >=dev-libs/libxml2-2.5 )
	gtk?	( >=x11-libs/gtk+-2.0
		  x11-libs/pango )
	sox? 	( media-sound/sox )
	quicktime? ( media-libs/libquicktime )
	xine? ( >=media-libs/xine-lib-1.1.2_pre20060328-r7 )
	lame? ( >=media-sound/lame-3.97_beta2 )
	theora? ( >=media-libs/libtheora-1.0_alpha5 )"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A}
	cd "${S}"
	use amd64 && epatch "${FILESDIR}/mlt-0.2.2-motion-est-amd64.patch"
	epatch "${FILESDIR}/mlt-0.2.2-motion-est-nonx86.patch"
}

src_compile() {

	local myconf="	--enable-gpl --enable-shared
			--enable-pp --enable-shared-pp
			--enable-motion-est
			$(use_enable dv)
			$(use_enable mmx)
			$(use_enable gtk gtk2)
			$(use_enable vorbis)
			$(use_enable ogg)
			$(use_enable sdl)
			$(use_enable jack jackrack)
			$(use_enable sox)
			$(use_enable theora)
			$(use_enable lame mp3lame)
			$(use_enable xine)"

	(use quicktime || use dv) ||  myconf="${myconf} --disable-kino"

	econf ${myconf} || die "econf failed"
	sed -i -e s/^OPT/#OPT/ "${S}/config.mak"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc docs/*.txt ChangeLog README docs/TODO

	dodir /usr/share/${PN}
	insinto /usr/share/${PN}
	doins -r demo
}
