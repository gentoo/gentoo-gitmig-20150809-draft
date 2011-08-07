# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.6.4-r1.ebuild,v 1.1 2011/08/07 16:48:41 xarthisius Exp $

EAPI=4
GCONF_DEBUG=no
inherit eutils gnome2

DESCRIPTION="GnomeBaker is a GTK2/Gnome cd burning application."
HOMEPAGE="http://sourceforge.net/projects/gnomebaker"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dvdr flac libnotify mp3 vorbis"

RDEPEND="x11-libs/gtk+:2
	gnome-base/libgnomeui
	dev-libs/libxml2:2
	gnome-base/libglade:2.0
	media-libs/gstreamer:0.10
	x11-libs/cairo
	app-cdr/cdrdao
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )
	flac? ( media-plugins/gst-plugins-flac
		media-libs/gst-plugins-good )
	libnotify? ( x11-libs/libnotify )
	mp3? ( media-plugins/gst-plugins-mad
		media-libs/gst-plugins-good )
	vorbis? ( media-plugins/gst-plugins-vorbis
		media-libs/libogg
		media-libs/gst-plugins-good )"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		$(use_enable libnotify)"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch \
		"${FILESDIR}"/${P}-ldadd.patch \
		"${FILESDIR}"/${P}-seldata.patch \
		"${FILESDIR}"/${P}-mimetype.patch \
		"${FILESDIR}"/${P}-implicits.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=/usr/share/doc/${P} \
		docdir=/usr/share/gnome/help/${PN}/C \
		gnomemenudir=/usr/share/applications
	rm -rf "${D}"/usr/share/doc/${P}/*.make "${D}"/var
}
