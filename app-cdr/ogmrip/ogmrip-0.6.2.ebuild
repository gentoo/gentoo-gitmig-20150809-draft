# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/ogmrip/ogmrip-0.6.2.ebuild,v 1.3 2005/03/30 13:51:29 luckyduck Exp $

inherit gnome2 eutils

DESCRIPTION="Application and libraries for encoding DVDs into DivX/OGM files"
HOMEPAGE="http://ogmrip.sourceforge.net/"
SRC_URI="mirror://sourceforge/ogmrip/${P}.tar.gz"
LICENSE="LGPL-2.1"

SLOT="0"
IUSE="gnome matroska doc subp"
KEYWORDS="~x86 ~ppc ~amd64"

RDEPEND=">=dev-libs/glib-2.4.6
	>=media-libs/libdvdread-0.9.4
	>=media-sound/ogmtools-1.4
	>=media-sound/vorbis-tools-1.0
	>=media-sound/lame-3.96
	>=media-video/mplayer-1.0_pre4
	matroska? ( >=media-video/mkvtoolnix-0.9 )
	gnome? ( >=gnome-base/gconf-2.6
		>=gnome-base/libgnomeui-2.6
		>=gnome-base/libglade-2.4 )
	subp? ( >=app-text/gocr-0.39
		>=app-text/enchant-1.1 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_enable gnome gnome-support) $(use_enable debug maintainer-mode) $(use_enable subp enchant-support)"

DOCS="AUTHORS ChangeLog COPYING README INSTALL NEWS TODO"

pkg_setup() {
	if ! which mencoder 2> /dev/null; then
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
