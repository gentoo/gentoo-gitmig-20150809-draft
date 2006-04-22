# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/graveman/graveman-0.3.12_p4-r1.ebuild,v 1.11 2006/04/22 14:57:07 metalgod Exp $

inherit gnome2 eutils

DESCRIPTION="Graphical frontend for cdrecord, mkisofs, readcd and sox using GTK+2"
HOMEPAGE="http://graveman.tuxfamily.org/"
SRC_URI="http://graveman.tuxfamily.org/sources/${PN}-${PV/_p/-}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="debug dvdr flac mp3 nls vorbis"

DEPEND=">=x11-libs/gtk+-2.4
	>=dev-libs/glib-2.4
	>=gnome-base/libglade-2.4
	>=dev-util/intltool-0.22
	flac? ( >=media-libs/flac-1.1.0 )
	nls? ( sys-devel/gettext )
	mp3? ( >=media-libs/libid3tag-0.15
		>=media-libs/libmad-0.15 )
	vorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"
RDEPEND="${DEPEND}
	>=app-cdr/cdrtools-2.0
	>=app-cdr/cdrdao-1.1.9
	media-libs/libmng
	dvdr? ( >=app-cdr/dvd+rw-tools-5.20 )
	vorbis? ( >=media-sound/sox-12.17.0 )
	mp3? ( >=media-sound/sox-12.17.0 )
	nls? ( virtual/libintl )"

G2CONF="${G2CONF} \
	$(use_enable flac) \
	$(use_enable mp3) \
	$(use_enable vorbis ogg) \
	$(use_enable debug)"

S=${WORKDIR}/${P/_p/-}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/joliet-long.patch
}
DOCS="AUTHORS ChangeLog INSTALL NEWS README* THANKS"
USE_DESTDIR="1"
