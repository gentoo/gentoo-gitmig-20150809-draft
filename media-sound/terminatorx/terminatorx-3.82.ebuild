# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/terminatorx/terminatorx-3.82.ebuild,v 1.16 2010/10/24 16:39:59 armin76 Exp $

inherit gnome2 eutils

MY_P=${P/terminatorx/terminatorX}
S=${WORKDIR}/${MY_P}
DESCRIPTION='realtime audio synthesizer that allows you to "scratch" on digitally sampled audio data'
HOMEPAGE="http://www.terminatorx.org/"
SRC_URI="http://www.terminatorx.org/dist/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="alsa mad vorbis sox"

RDEPEND="alsa? ( media-libs/alsa-lib )
	mad? ( media-sound/madplay )
	vorbis? ( media-libs/libvorbis )
	sox? ( media-sound/sox
		media-sound/mpg123 )
	>=x11-libs/gtk+-2.2
	>=dev-libs/glib-2.2
	x11-libs/libXi
	x11-libs/libXxf86dga
	dev-libs/libxml2
	media-libs/audiofile
	media-libs/ladspa-sdk
	media-libs/ladspa-cmt
	app-text/scrollkeeper
	media-libs/liblrdf"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto
	x11-proto/inputproto
	x11-proto/xf86dgaproto"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# we need the omf fix, or else we get access violation
	# errors related to sandbox
	gnome2_omf_fix "${S}/doc/terminatorX-manual/C/Makefile.in"
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable mad) \
		$(use_enable vorbis) \
		$(use_enable sox) \
		|| die "econf failed"
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	newicon gnome-support/terminatorX-app.png terminatorX.png
	make_desktop_entry terminatorX terminatorX terminatorX AudioVideo
}
