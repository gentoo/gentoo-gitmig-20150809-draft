# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/gnomebaker/gnomebaker-0.6.4.ebuild,v 1.7 2011/01/29 20:05:33 ssuominen Exp $

EAPI=3
GCONF_DEBUG=no
inherit eutils gnome2

DESCRIPTION="GnomeBaker is a GTK2/Gnome cd burning application."
HOMEPAGE="http://sourceforge.net/projects/gnomebaker"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE="dvdr flac libnotify mp3 vorbis"

RDEPEND=">=x11-libs/gtk+-2.8
	>=gnome-base/libgnomeui-2.8.1
	>=dev-libs/libxml2-2.4
	>=gnome-base/libglade-2.4.2
	>=media-libs/gstreamer-0.10
	x11-libs/cairo
	app-cdr/cdrdao
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )
	flac? ( >=media-plugins/gst-plugins-flac-0.10
		media-libs/gst-plugins-good )
	libnotify? ( x11-libs/libnotify )
	mp3? ( >=media-plugins/gst-plugins-mad-0.10
		media-libs/gst-plugins-good	)
	vorbis? ( >=media-plugins/gst-plugins-vorbis-0.10
		>=media-libs/libogg-1.1.2
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
	epatch "${FILESDIR}"/${P}-libnotify-0.7.patch
	gnome2_src_prepare
}

src_install() {
	gnome2_src_install \
		gnomebakerdocdir=/usr/share/doc/${P} \
		docdir=/usr/share/gnome/help/${PN}/C \
		gnomemenudir=/usr/share/applications
	rm -rf "${D}"/usr/share/doc/${P}/*.make "${D}"/var
}
