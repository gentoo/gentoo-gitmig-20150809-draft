# Copyrieht 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gpxviewer/gpxviewer-0.2.0.ebuild,v 1.3 2011/03/02 18:03:00 jlec Exp $

EAPI="2"

inherit autotools eutils

MY_PN="gpx-viewer"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Simple program to visualize a gpx file"
HOMEPAGE="http://blog.sarine.nl/${PN}/"
SRC_URI="http://edge.launchpad.net/${MY_PN}/trunk/${PV}/+download/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls"

RDEPEND="
	dev-lang/vala:0.12
	dev-libs/gdl
	dev-libs/glib:2
	dev-libs/libunique
	dev-libs/libxml2:2
	media-libs/libchamplain:0.6[gtk]
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	dev-util/pkgconfig"

S="${WORKDIR}"/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${PV}-configure.ac.patch"
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable nls)
}

src_compile() {
	emake gpx_viewer_vala.stamp || die
	emake || die
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dosym ../icons/hicolor/scalable/apps/gpx-viewer.svg /usr/share/pixmaps/gpx-viewer.svg || die
	dodoc AUTHORS README ChangeLog || die "dodoc failed"
}
