# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.4.ebuild,v 1.6 2004/02/09 03:27:14 eradicator Exp $

IUSE="debug esd X gtk oggvorbis gnome arts nls"

inherit kde-functions

S=${WORKDIR}/${P}
DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
HOMEPAGE="http://www.zinf.org/"

RDEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	sys-libs/zlib
	>=sys-libs/ncurses-5.2
	=media-libs/freetype-1*
	>=media-libs/musicbrainz-1.0.1
	>=media-libs/id3lib-3.8.0
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	gtk? ( >=media-libs/gdk-pixbuf-0.8 )
	gnome? ( gnome-base/ORBit )
	oggvorbis? ( media-libs/libvorbis )
	arts? ( kde-base/arts )"
#	alsa? ( >=media-libs/alsa-lib-0.9.8 ) # Broken in 2.2.4

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	nls? ( sys-devel/gettext )
	>=media-libs/id3lib-3.8.0
	dev-lang/perl"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/zinf-2.2.4-pref.patch
}

src_compile() {
	local myconf="--enable-cmdline"

	myconf="${myconf} `use_enable debug`"
	myconf="${myconf} `use_enable esd`"
	myconf="${myconf} `use_enable arts`"
#	myconf="${myconf} `use_enable alsa`"
	myconf="${myconf} --disable-alsa"
	myconf="${myconf} `use_enable gnome cobra`"

	if use arts; then
		set-kdedir 3
		export ARTSCCONFIG="$KDEDIR/bin/artsc-config"
	fi

	econf ${myconf} || die
	make || die
}

src_install() {
	into /usr
	dobin base/zinf

	exeinto /usr/lib/zinf/plugins
	doexe plugins/*

	insinto /usr/share/zinf/themes
	doins themes/*

	dodoc AUTHORS ChangeLog NEWS README
}

pkg_postinst() {
	einfo "Also support has been disabled in 2.2.4 due to compilation problems."
	einfo "If you require alsa support, please use another version."
}
