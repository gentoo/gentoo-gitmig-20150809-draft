# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogmrip/ogmrip-0.9.0-r1.ebuild,v 1.3 2006/08/30 16:20:40 zzam Exp $

inherit autotools eutils gnome2

DESCRIPTION="Application and libraries for encoding DVDs into AVI/OGM files"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
IUSE="debug gnome hal matroska subp"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-libs/glib-2.6
	>=media-libs/libdvdread-0.9.4
	>=media-sound/ogmtools-1.4
	>=media-sound/vorbis-tools-1.0
	>=media-sound/lame-3.96
	>=media-video/mplayer-1.0_pre4
	matroska? ( >=media-video/mkvtoolnix-0.9 )
	gnome? ( >=x11-libs/gtk+-2.6
		>=gnome-base/gconf-2.6
		>=gnome-base/libgnomeui-2.6
		>=gnome-base/libglade-2.5 )
	subp? ( >=app-text/gocr-0.39
		>=app-text/enchant-1.1 )
	hal? ( >=sys-apps/hal-0.4.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable gnome gnome-support) $(use_enable debug maintainer-mode) $(use_enable subp enchant-support) $(use_enable hal hal-support)"

DOCS="AUTHORS ChangeLog README NEWS TODO"

pkg_setup() {
	if ! built_with_use -a media-video/mplayer dvd encode xvid; then
		eerror "Please, check that your USE flags contain 'dvd', 'encode' and"
		eerror "'xvid' and emerge mplayer again."
		die "Mplayer is not build with dvd, encoding or xvid support. OGMRip" \
		"requires dvd, encoding and xvid support in mplayer."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-lang.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-mplayercvs.patch"
	epatch "${FILESDIR}/${P}-types.patch"
	eautoreconf
}
