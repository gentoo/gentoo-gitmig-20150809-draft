# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.3.11.ebuild,v 1.5 2005/07/07 00:05:55 agriffis Exp $

inherit gnome2

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://graveman.tuxfamily.org/"
SRC_URI="http://graveman.tuxfamily.org/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="debug dvdr flac mp3 nls oggvorbis sox"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2.4
	>=dev-util/intltool-0.22
	flac? ( >=media-libs/flac-1.1.0 )
	nls? ( sys-devel/gettext )
	mp3? ( >=media-libs/libid3tag-0.15
		>=media-libs/libmad-0.15 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-2.0
	>=app-cdr/cdrdao-1.1.9
	media-libs/libmng
	dvdr? ( >=app-cdr/dvd+rw-tools-5.20 )
	sox? ( >=media-sound/sox-12.17.0 )"

G2CONF="${G2CONF} \
	$(use_enable flac) \
	$(use_enable mp3) \
	$(use_enable oggvorbis ogg) \
	$(use_enable debug)"

DOCS="AUTHORS ChangeLog INSTALL NEWS README* THANKS"
USE_DESTDIR="1"
