# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/glame/glame-2.0.1.ebuild,v 1.12 2009/05/09 15:02:55 gentoofan23 Exp $

WANT_AUTOCONF=2.5

inherit autotools eutils

DESCRIPTION="an audio file editing utility"
HOMEPAGE="http://glame.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
IUSE="nls gnome vorbis debug alsa"

RDEPEND=">=dev-scheme/guile-1.4-r3
	>=dev-libs/libxml-1.8
	>=dev-libs/libxml2-2
	>=media-sound/esound-0.2
	>=media-libs/audiofile-0.2.2
	=sci-libs/fftw-2*
	media-libs/libmad
	media-libs/ladspa-sdk
	vorbis? ( >=media-libs/libvorbis-1 )
	gnome? ( >=gnome-base/libglade-2 >=gnome-base/libgnome-2.6
		>=gnome-base/libgnome-2.6 >=gnome-base/libgnomecanvas-2.6
		>=dev-libs/glib-2.6 >=x11-libs/gtk+-2.6 >=gnome-base/libgnomeui-2.6 )
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	nls? ( >=sys-devel/gettext-0.11.3 )"

pkg_setup() {
	if has_version =dev-scheme/guile-1.8*; then
		built_with_use dev-scheme/guile deprecated || die "guile must be built with deprecated use flag."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"/libltdl
	eautoconf
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cflags.patch
	sed -i -e 's:glame.png:glame-logo.jpg:' src/gui/glame.desktop
}

src_compile() {
	econf $(use_enable alsa alsatest) \
		$(use_enable debug swapfiledebug) $(use_enable debug) \
		$(use_enable gnome gui) \
		$(use_enable nls) \
		--enable-ladspa \
		${myconf}

	emake || die "emake failed."
}

src_install() {
	einstall || die "einstall failed."

	if use gnome; then
		dodir /usr/share/pixmaps
		dosym ../glame/pixmaps/glame-logo.jpg /usr/share/pixmaps/glame-logo.jpg
	fi

	dodoc AUTHORS BUGS CREDITS ChangeLog MAINTAINERS NEWS README TODO
}
