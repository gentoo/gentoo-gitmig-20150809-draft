# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/subtitleeditor/subtitleeditor-0.30.0.ebuild,v 1.1 2009/02/01 10:47:24 eva Exp $

EAPI="1"

inherit eutils

DESCRIPTION="GTK+2 subtitle editing tool."
HOMEPAGE="http://home.gna.org/subtitleeditor/"
SRC_URI="http://download.gna.org/${PN}/${PV%.*}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug opengl"

RDEPEND=">=x11-libs/gtk+-2.12
	>=dev-cpp/gtkmm-2.12
	>=dev-cpp/glibmm-2.16.3
	>=dev-cpp/libglademm-2.4
	>=dev-cpp/libxmlpp-2.10
	>=app-text/enchant-1.1.0
	opengl? ( >=dev-cpp/gtkglextmm-1.2 )
	>=media-libs/gstreamer-0.10
	>=media-libs/gst-plugins-good-0.10
	>=media-plugins/gst-plugins-meta-0.10-r2:0.10
	app-text/iso-codes"
#>=media-plugins/gst-plugins-pango-0.10

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.40
	dev-util/pkgconfig"

src_compile() {
	intltoolize --copy --force --automake || die "intltoolize failed"
	export GST_REGISTRY="${T}/home/registry.cache.xml"

	# USE="debug" seems to turn on some debug path
	econf \
		$(use_enable debug) \
		$(use_enable opengl gl)
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	ewarn
	ewarn "If ${PN} doesn't play some video format, please check your"
	ewarn "USE flags on media-plugins/gst-plugins-meta"
	ewarn
}
