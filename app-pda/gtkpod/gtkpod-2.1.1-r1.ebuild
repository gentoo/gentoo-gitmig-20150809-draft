# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/gtkpod/gtkpod-2.1.1-r1.ebuild,v 1.2 2012/03/21 09:22:41 ssuominen Exp $

EAPI=4
inherit eutils gnome2-utils

DESCRIPTION="A graphical user interface to the Apple productline"
HOMEPAGE="http://gtkpod.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2 FDL-1.2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac clutter curl flac gstreamer mp3 vorbis webkit"

COMMON_DEPEND="dev-libs/gdl:3
	>=dev-libs/glib-2.28.5
	>=dev-libs/libxml2-2.7.7
	>=dev-util/anjuta-2.91
	>=media-libs/libgpod-0.7.0
	>=media-libs/libid3tag-0.15
	>=x11-libs/gtk+-3.0.8:3
	aac? (
		media-libs/faad2
		>=media-libs/libmp4v2-1.9.1
		)
	clutter? ( media-libs/clutter-gtk:1.0 )
	curl? ( >=net-misc/curl-7.10 )
	flac? ( media-libs/flac )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.25:0.10 )
	mp3? ( media-sound/lame )
	vorbis? (
		media-libs/libvorbis
		media-sound/vorbis-tools
		)
	webkit? ( >=net-libs/webkit-gtk-1.3:3 )"
RDEPEND="${COMMON_DEPEND}
	gstreamer? ( media-plugins/gst-plugins-meta:0.10 )"
DEPEND="${COMMON_DEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/flex
	sys-devel/gettext
	virtual/os-headers"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1.1-libmp4v2_so_2.patch
}

src_configure() {
	econf \
		--disable-static \
		$(use_enable webkit plugin-coverweb) \
		$(use_enable clutter plugin-clarity) \
		$(use_enable gstreamer plugin-media-player) \
		$(use_with curl) \
		$(use_with vorbis ogg) \
		$(use_with flac) \
		$(use_with aac faad)
}

src_install() {
	emake \
		DESTDIR="${D}" \
		docdir=/usr/share/doc/${PF}/html \
		figuresdir=/usr/share/doc/${PF}/html/figures \
		install

	dodoc AUTHORS ChangeLog NEWS README TODO TROUBLESHOOTING

	find "${D}" -name '*.la' -exec rm -f {} +
	rm -f "${D}"/usr/share/gtkpod/data/{AUTHORS,COPYING}
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
