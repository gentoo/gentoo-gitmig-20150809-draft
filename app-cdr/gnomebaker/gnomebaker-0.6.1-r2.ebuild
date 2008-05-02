# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.6.1-r2.ebuild,v 1.9 2008/05/02 14:55:51 cardoe Exp $

inherit eutils gnome2

DESCRIPTION="GnomeBaker is a GTK2/Gnome cd burning application."
HOMEPAGE="http://gnomebaker.sf.net"
SRC_URI="mirror://sourceforge/gnomebaker/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="dvdr nls mp3 flac vorbis libnotify"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
RDEPEND="app-cdr/cdrdao
	virtual/cdrtools
	>=dev-libs/glib-2.4.0
	>=dev-libs/libxml2-2.4.0
	>=gnome-base/libglade-2.4.2
	>=gnome-base/libgnomeui-2.10
	>=media-libs/gstreamer-0.10.0
	x11-libs/cairo
	>=x11-libs/gtk+-2.8
	dev-perl/XML-Parser
	dvdr? ( app-cdr/dvd+rw-tools )
	flac? ( >=media-plugins/gst-plugins-flac-0.10.0
		media-libs/gst-plugins-good )
	libnotify? ( x11-libs/libnotify )
	mp3? ( >=media-plugins/gst-plugins-mad-0.10.0
		media-libs/gst-plugins-good	)
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10.0
		>=media-libs/libogg-1.1.2
		media-libs/gst-plugins-good )"
DEPEND="${RDEPEND}
	app-text/scrollkeeper"

G2CONF="${G2CONF} \
	$(use_enable libnotify)"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-export-dynamic_for_glade.patch"
	epatch "${FILESDIR}/${P}-thread_init.patch"

	gnome2_omf_fix
}

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=/usr/share/doc/${P} \
		docdir=/usr/share/gnome/help/${PN}/C \
		gnomemenudir=/usr/share/applications
	rm -rf "${D}"/usr/share/doc/${P}/*.make "${D}"/var
	use nls || rm -rf "${D}"/usr/share/locale
}
