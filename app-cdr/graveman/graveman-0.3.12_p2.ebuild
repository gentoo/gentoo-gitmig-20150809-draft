# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.3.12_p2.ebuild,v 1.1 2005/05/24 20:19:12 dertobi123 Exp $

inherit gnome2

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://graveman.tuxfamily.org/"
SRC_URI="http://graveman.tuxfamily.org/sources/${PN}-${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE="debug doc dvdr flac mad nls oggvorbis sox"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2.0
	>=dev-util/intltool-0.22
	flac? ( >=media-libs/flac-1.1.0 )
	nls? ( sys-devel/gettext )
	mad? ( >=media-libs/libid3tag-0.15
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
	$(use_enable mad mp3) \
	$(use_enable oggvorbis ogg) \
	$(use_enable debug)"

S=${WORKDIR}/${P/_p/-}

DOCS="AUTHORS ChangeLog INSTALL NEWS README* THANKS"
USE_DESTDIR="1"
