# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mlt/mlt-0.2.2.ebuild,v 1.1 2006/07/17 07:14:37 zypher Exp $

inherit eutils

DESCRIPTION="MLT is an open source multimedia framework, designed and developed
for television broadcasting"
HOMEPAGE="http://mlt.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlt/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dv xml jack gtk sdl vorbis sox quicktime mmx lame xine lame ogg \
	theora doc xine"

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

src_unpack() {
	unpack ${A}
	cd ${S}
	( use amd64 ) && epatch ${FILESDIR}/mlt-0.2.2-motion-est-amd64.patch
}

src_compile() {

	local myconf="	--enable-gpl --enable-shared
			--enable-pp --enable-shared-pp
			--enable-motion-est
			$(use_enable dv)
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

	econf $myconf
	sed -e s/^OPT/#OPT/ -i ${S}/config.mak
	emake || die
}

src_install() {
	make DESTDIR="${D}" install
	use doc && dodoc docs/*.txt

	dodoc ChangeLog COPYING README docs/TODO

	dodir /usr/share/mlt
	insinto /usr/share/mlt
	doins -r demo
}

