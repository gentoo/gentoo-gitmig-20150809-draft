# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/ogmrip/ogmrip-0.9.0.ebuild,v 1.1 2005/08/20 11:45:02 metalgod Exp $

inherit gnome2 eutils

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

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

pkg_setup() {
	if ! which mencoder > /dev/null 2>&1; then
		eerror "Unable to find mencoder in the PATH. You need mencoder to use OGMRip."
		eerror "Please, add encode to your USE flags and emerge mplayer again."
		die "Unable to find mencoder in the PATH. You need mencoder to use OGMRip."
	fi
	if ! mencoder -ovc help 2> /dev/null | grep -q "^ *xvid *- .*$"; then
		echo
		eerror "Mplayer is not build with XviD support. OGMRip requires XviD support in mplayer."
		eerror "Please, add xvid to your USE flags and emerge mplayer again."
		die "Mplayer is not build with XviD support. OGMRip requires XviD support in mplayer."
	fi
}
src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/ogmrip-0.9.0-lang.patch
}
