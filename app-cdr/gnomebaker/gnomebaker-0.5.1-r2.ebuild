# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.5.1-r2.ebuild,v 1.4 2006/04/29 09:07:20 dertobi123 Exp $

inherit eutils gnome2

DESCRIPTION="GnomeBaker is a GTK2/Gnome cd burning application."
HOMEPAGE="http://gnomebaker.sf.net"
SRC_URI="mirror://sourceforge/gnomebaker/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="dvdr nls mp3 flac vorbis"
KEYWORDS="amd64 ~ia64 ppc ~sparc ~x86"

DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.10
	=media-libs/gstreamer-0.8*
	app-text/scrollkeeper"

RDEPEND="${DEPEND}
	dvdr? ( app-cdr/dvd+rw-tools )
	mp3? ( =media-plugins/gst-plugins-mad-0.8* )
	vorbis? ( =media-plugins/gst-plugins-vorbis-0.8*
		>=media-libs/libogg-1.1.2 )
	flac? ( =media-plugins/gst-plugins-flac-0.8* )
	app-cdr/cdrdao
	virtual/cdrtools"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-headerfix.patch

	gnome2_omf_fix
}

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=${D}/usr/share/doc/${P} \
		docdir=${D}/usr/share/gnome/help/${PN}/C \
		gnomemenudir=${D}/usr/share/applications
	rm -rf ${D}/usr/share/doc/${P}/*.make ${D}/var
	use nls || rm -rf ${D}/usr/share/locale
}
