# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-2.0.1.ebuild,v 1.9 2007/01/10 19:48:01 peper Exp $

WANT_AUTOCONF=2.5

inherit eutils autotools

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="nls gnome vorbis debug alsa"

RDEPEND=">=dev-scheme/guile-1.4-r3
	>=dev-libs/libxml-1.8.0
	>=dev-libs/libxml2-2.0.0
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	=sci-libs/fftw-2*
	media-libs/libmad
	media-libs/ladspa-sdk
	vorbis? ( >=media-libs/libvorbis-1.0 )
	gnome? ( >=gnome-base/libglade-2 >=gnome-base/libgnome-2.6\
	>=gnome-base/libgnome-2.6 >=gnome-base/libgnomecanvas-2.6\
	>=dev-libs/glib-2.6 >=x11-libs/gtk+-2.6.0 )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.3 )"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}

	# fix makefile problem
	cd ${S}/libltdl
	eautoconf

	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch
}

src_compile() {
	if use gnome
	then
		# Use a valid icon for the GNOME menu entry
		cp src/gui/glame.desktop src/gui/glame.desktop.old
		sed -e 's:glame.png:glame-logo.jpg:' \
			src/gui/glame.desktop.old > src/gui/glame.desktop
		rm src/gui/glame.desktop.old
	fi

	econf \
		$(use_enable alsa alsatest) \
		$(use_enable debug swapfiledebug) $(use_enable debug) \
		$(use_enable gnome gui) \
		$(use_enable nls) \
		--enable-ladspa \
		${myconf} || die "Configuration failed"

	emake || die "Compilation failed"
}

src_install () {
	einstall || die "Installation failed"

	if use gnome
	then
		dodir /usr/share/pixmaps
		dosym ../glame/pixmaps/glame-logo.jpg \
		      /usr/share/pixmaps/glame-logo.jpg
	fi

	dodoc AUTHORS BUGS CREDITS ChangeLog MAINTAINERS \
		NEWS README TODO
}
