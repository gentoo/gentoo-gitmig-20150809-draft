# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.3.8.ebuild,v 1.2 2005/03/30 00:13:43 pylon Exp $

inherit gnome2

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://www.nongnu.org/graveman/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug doc dvdr mad nls oggvorbis sox"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2.0
	>=dev-util/intltool-0.22
	nls? ( sys-devel/gettext )
	mad? ( >=media-libs/libid3tag-0.15
		>=media-libs/libmad-0.15 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	dvdr? ( app-cdr/dvd+rw-tools )"
RDEPEND="${DEPEND}
	sox? ( >=media-sound/sox-12.17.0 )
	>=app-cdr/cdrtools-2.0"

G2CONF="${G2CONF} $(use_enable mad mp3) $(use_enable oggvorbis ogg) \
	$(use_enable debug)"
DOCS="AUTHORS ChangeLog INSTALL NEWS README* THANKS"
USE_DESTDIR="1"
