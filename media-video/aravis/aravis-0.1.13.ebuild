# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/aravis/aravis-0.1.13.ebuild,v 1.2 2012/05/05 08:58:57 jdhore Exp $

EAPI=4

KEYWORDS="~amd64"

if [[ ${PV} == "9999" ]]; then
	KEYWORDS=""
	EGIT_REPO_URI="git://git.gnome.org/aravis"
	EGIT_COMMIT="${aravis_LIVE_COMMIT:-master}"
fi

inherit versionator ${EGIT_COMMIT+git-2 autotools}

DESCRIPTION="Library for video acquisition using Genicam cameras."
HOMEPAGE="http://live.gnome.org/Aravis"

LICENSE="LGPL-2.1"
SLOT="0"

IUSE="X gstreamer"

GST_DEPEND="media-libs/gstreamer
	media-libs/gst-plugins-base"

RDEPEND=">=dev-libs/glib-2.22
	dev-libs/libxml2
	X? (
		>=x11-libs/gtk+-2.12:2
		${GST_DEPEND}
		media-libs/gst-plugins-base
		media-plugins/gst-plugins-xvideo
	)
	gstreamer? ( ${GST_DEPEND} )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-libs/gobject-introspection"

if [[ -z ${EGIT_COMMIT} ]]; then
	SRC_URI="mirror://gnome/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.xz"
else
	DEPEND+=" dev-util/gtk-doc dev-util/intltool"
fi

src_prepare() {
	if [[ -n ${EGIT_COMMIT} ]]; then
		intltoolize || die
		gtkdocize || die
		eautoreconf
	fi
}

src_configure() {
	econf \
		--disable-silent-rules \
		--disable-static \
		$(use_enable X viewer) \
		$(use_enable gstreamer gst-plugin) \
		--enable-introspection
}

src_install() {
	emake install DESTDIR="${D}" aravisdocdir="/usr/share/doc/${PF}"
	find "${D}" -name '*.la' -delete
}
