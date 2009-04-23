# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-1.0.5.ebuild,v 1.1 2009/04/23 05:56:27 zmedico Exp $

inherit eutils

MY_P=${PN}-src-${PV}

DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.berlios.de"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	>=dev-libs/glib-2
	>=media-video/ffmpeg-0.4.9_p20090201
	>=media-libs/libsdl-1.2.10
	>=media-libs/portaudio-19_pre
	media-libs/libpng
	media-sound/twolame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	rm -rf "${D}"/usr/share/doc/${PN} "${D}"/usr/share/menu || die "rm -rf failed."
	dodoc AUTHORS ChangeLog README
}
