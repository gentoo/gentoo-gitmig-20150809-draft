# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.5.ebuild,v 1.5 2004/03/26 21:13:37 eradicator Exp $

inherit kde-functions eutils

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
HOMEPAGE="http://www.zinf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -sparc"
IUSE="debug esd X gtk oggvorbis gnome arts alsa nls ipv6"

RDEPEND=">=dev-libs/glib-2.0.0
	sys-libs/zlib
	>=sys-libs/ncurses-5.2
	>=media-libs/musicbrainz-1.0.1
	X? ( virtual/x11 )
	esd? ( media-sound/esound )
	gtk? ( >=x11-libs/gtk+-2.0.0 )
	gnome? ( >=gnome-base/ORBit-0.5.0 )
	oggvorbis? ( media-libs/libvorbis )
	alsa? ( >=media-libs/alsa-lib-0.9.8 )
	arts? ( kde-base/arts )"

# When updating next, check boost to see if the newer versions fix compilation
DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )
	nls? ( sys-devel/gettext )
	>=media-libs/id3lib-3.8.0
	dev-libs/boost
	dev-db/metakit
	dev-lang/perl"

src_compile() {
	local myconf="--enable-cmdline"

	myconf="${myconf} `use_enable debug`"
	myconf="${myconf} `use_enable esd`"
	myconf="${myconf} `use_enable arts`"
	myconf="${myconf} `use_enable alsa`"
	myconf="${myconf} `use_enable gnome corba`"
	myconf="${myconf} `use_enable ipv6`"

	if [ $ARCH == "amd64" ]; then
		replace-flags -O? -O
		append-flags -frerun-cse-after-loop
	fi

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
