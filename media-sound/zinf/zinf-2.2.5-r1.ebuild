# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.5-r1.ebuild,v 1.5 2004/07/15 08:24:21 eradicator Exp $

inherit kde-functions eutils flag-o-matic

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
HOMEPAGE="http://www.zinf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 -sparc"
IUSE="debug esd X gtk oggvorbis gnome arts alsa nls ipv6"

RDEPEND=">=dev-libs/glib-2.0.0
	sys-libs/gdbm
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
	>=sys-devel/automake-1.7
	dev-lang/perl"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-cdplay.patch
	epatch ${FILESDIR}/${P}-configure.patch

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	ebegin "Running aclocal (${WANT_AUTOMAKE})"
	aclocal -I m4
	eend $?

	ebegin "Running automake (${WANT_AUTOMAKE})"
	automake
	eend $?

	ebegin "Running autoconf (${WANT_AUTOCONF})"
	autoconf
	eend $?
}

src_compile() {
	local myconf="--enable-cmdline"

	use x86 || myconf="${myconf} --disable-x86opts"

	myconf="${myconf} `use_enable debug`"
	myconf="${myconf} `use_enable esd`"
	myconf="${myconf} `use_enable arts`"
	myconf="${myconf} `use_enable alsa`"
	myconf="${myconf} `use_enable gnome corba`"
	myconf="${myconf} `use_enable ipv6`"

	if use amd64; then
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
