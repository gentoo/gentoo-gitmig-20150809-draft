# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/guvcview/guvcview-0.9.6.ebuild,v 1.1 2008/12/09 20:34:16 ssuominen Exp $

MY_P=${PN}-src-${PV}

DESCRIPTION="GTK+ UVC Viewer"
HOMEPAGE="http://guvcview.berlios.de"
SRC_URI="mirror://berlios/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.10
	>=media-libs/libsdl-1.2.10
	>=media-libs/portaudio-19_pre
	media-libs/libpng
	media-sound/twolame"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf --disable-dependency-tracking
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	rm -rf "${D}"/usr/share/doc/${PN} "${D}"/usr/share/menu || die "rm -rf failed."
	dodoc AUTHORS ChangeLog README
}
