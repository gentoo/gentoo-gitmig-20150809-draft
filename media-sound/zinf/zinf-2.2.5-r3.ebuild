# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/zinf/zinf-2.2.5-r3.ebuild,v 1.3 2006/07/11 12:44:43 tcort Exp $

inherit kde-functions eutils flag-o-matic libtool

DESCRIPTION="An extremely full-featured mp3/vorbis/cd player with ALSA support, previously called FreeAmp"
HOMEPAGE="http://www.zinf.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -sparc ~x86"
IUSE="alsa arts corba debug esd gtk ipv6 mp3 nls vorbis xosd X"

RDEPEND=">=dev-libs/glib-2
	sys-libs/gdbm
	sys-libs/zlib
	>=sys-libs/ncurses-5.2
	>=media-libs/musicbrainz-1.0.1
	alsa? ( >=media-libs/alsa-lib-0.9.8 )
	arts? ( kde-base/arts )
	corba? ( =gnome-base/orbit-0* )
	esd? ( >=media-sound/esound-0.2.12 )
	gtk? ( >=x11-libs/gtk+-2 )
	mp3? ( >=media-libs/id3lib-3.8.0 )
	vorbis? ( media-libs/libvorbis )
	xosd? ( x11-libs/xosd )"

# When updating next, check boost to see if the newer versions fix compilation
DEPEND="${RDEPEND}
	dev-lang/perl
	>=sys-devel/automake-1.7
	nls? ( sys-devel/gettext )
	x86? ( dev-lang/nasm )"
#	experimental? (
#		>=dev-cpp/gtkmm-2
#		app-office/mdbtools
#		dev-db/metakit
#		dev-libs/boost
#	)

src_unpack() {
	unpack ${A}; cd "${S}"

	epatch "${FILESDIR}"/${P}-cdplay.patch
	epatch "${FILESDIR}"/${P}-configure.patch
	epatch "${FILESDIR}"/${P}-rtp.patch

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	touch aclocal.m4

	ebegin "Running automake (${WANT_AUTOMAKE})"
	automake || die
	eend $?

	ebegin "Running autoconf (${WANT_AUTOCONF})"
	autoconf || die
	eend $?

	# fix #94149
	elibtoolize
}

src_compile() {
	local myconf

	myconf="${myconf} --enable-cmdline"

	# --disable-xosd is bork, #94143.
	if use xosd ; then
		myconf="${myconf} --enable-xosd"
	fi

	# --disable-corba is also bork.
	if use corba ; then
		myconf="${myconf} --enable-corba"
	fi

	if use amd64; then
		replace-flags -O? -O
		append-flags -frerun-cse-after-loop
	fi

	econf \
		$(use_enable alsa) \
		$(use_enable arts) \
		$(use_enable debug) \
		$(use_enable esd) \
		$(use_enable ipv6) \
		$(use_enable nls) \
		$(use_enable x86 x86opts) \
		${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
}
