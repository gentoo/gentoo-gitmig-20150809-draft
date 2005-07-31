# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.5-r2.ebuild,v 1.1 2005/07/31 20:17:22 vanquirius Exp $

inherit kde-functions eutils flag-o-matic libtool

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
HOMEPAGE="http://www.zinf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 -sparc"
IUSE="alsa arts debug esd gnome gtk ipv6 nls vorbis xosd X"

RESTRICT="primaryuri"

RDEPEND=">=dev-libs/glib-2.0.0
	sys-libs/gdbm
	sys-libs/zlib
	>=sys-libs/ncurses-5.2
	>=media-libs/musicbrainz-1.0.1
	alsa? ( >=media-libs/alsa-lib-0.9.8 )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )
	gnome? ( =gnome-base/orbit-0* )
	gtk? ( >=x11-libs/gtk+-2.0.0 )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )
	X? ( virtual/x11 )"

# When updating next, check boost to see if the newer versions fix compilation
DEPEND="${RDEPEND}
	dev-db/metakit
	dev-lang/perl
	dev-libs/boost
	>=media-libs/id3lib-3.8.0
	>=sys-devel/automake-1.7
	nls? ( sys-devel/gettext )
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/${P}-cdplay.patch
	epatch ${FILESDIR}/${P}-configure.patch
	epatch ${FILESDIR}/${P}-rtp.patch

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	touch aclocal.m4

	ebegin "Running automake (${WANT_AUTOMAKE})"
	automake
	eend $?

	ebegin "Running autoconf (${WANT_AUTOCONF})"
	autoconf
	eend $?

	# fix #94149
	elibtoolize
}

src_compile() {
	if use amd64; then
		replace-flags -O? -O
		append-flags -frerun-cse-after-loop
	fi

	if use arts; then
		set-kdedir 3
		export ARTSCCONFIG="$KDEDIR/bin/artsc-config"
	fi

	econf \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable debug) \
		$(use_enable esd) \
		$(use_enable ipv6) \
		$(use_enable gnome corba) \
		$(use_enable x86 x86opts) \
		$(use_enable xosd) \
		--enable-cmdline || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
