# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.6.1-r2.ebuild,v 1.4 2007/07/06 13:38:26 armin76 Exp $

inherit eutils gnome2

DESCRIPTION="GnomeBaker is a GTK2/Gnome cd burning application."
HOMEPAGE="http://gnomebaker.sf.net"
SRC_URI="mirror://sourceforge/gnomebaker/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="dvdr nls mp3 flac vorbis libnotify"
KEYWORDS="~amd64 ia64 ~ppc ppc64 sparc ~x86"
DEPEND=">=gnome-base/libglade-2.0
	>=gnome-base/libgnomeui-2.10
	>=media-libs/gstreamer-0.10.0
	dev-perl/XML-Parser
	libnotify? ( x11-libs/libnotify )
	app-text/scrollkeeper"
RDEPEND="${DEPEND}
	dvdr? ( app-cdr/dvd+rw-tools )
	mp3? ( >=media-plugins/gst-plugins-mad-0.10.0
		media-libs/gst-plugins-good	)
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.0
		>=media-libs/libogg-1.1.2
		media-libs/gst-plugins-good )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0
		media-libs/gst-plugins-good )
	app-cdr/cdrdao
	virtual/cdrtools"

G2CONF="${G2CONF} \
	$(use_enable libnotify)"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-export-dynamic_for_glade.patch"
	epatch "${FILESDIR}/${P}-thread_init.patch"

	gnome2_omf_fix
}

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=/usr/share/doc/${P} \
		docdir=/usr/share/gnome/help/${PN}/C \
		gnomemenudir=/usr/share/applications
	rm -rf ${D}/usr/share/doc/${P}/*.make ${D}/var
	use nls || rm -rf ${D}/usr/share/locale
}
