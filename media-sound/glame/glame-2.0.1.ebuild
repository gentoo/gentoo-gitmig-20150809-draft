# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-2.0.1.ebuild,v 1.2 2005/06/27 09:49:31 dholm Exp $

inherit eutils

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/glame/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="nls gnome vorbis debug alsa"

RDEPEND=">=dev-util/guile-1.4-r3
	>=dev-libs/libxml-1.8.0
	>=dev-libs/libxml2-2.0.0
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	=sci-libs/fftw-2*
	media-sound/madplay
	media-libs/ladspa-sdk
	vorbis? ( >=media-libs/libvorbis-1.0 )
	gnome? ( <gnome-base/libglade-2 gnome-base/gnome-libs )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58
	nls? ( >=sys-devel/gettext-0.11.3 )"

RESTRICT="primaryuri"

src_unpack() {
	unpack ${A}

	# fix makefile problem
	export WANT_AUTOCONF=2.5
	cd ${S}/libltdl
	autoconf -f

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

	dodoc ABOUT-NLS AUTHORS BUGS CREDITS ChangeLog MAINTAINERS \
		NEWS README TODO
}
