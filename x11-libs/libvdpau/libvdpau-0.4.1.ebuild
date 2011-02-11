# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libvdpau/libvdpau-0.4.1.ebuild,v 1.3 2011/02/11 12:32:45 phajdan.jr Exp $

EAPI=2
inherit multilib

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/VDPAU"
SRC_URI="http://people.freedesktop.org/~aplattner/vdpau/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 x86 ~x86-fbsd"
IUSE="doc"

#unfortunately, there's driver versions in between that this works with
RDEPEND="x11-libs/libX11
	x11-libs/libXext
	!=x11-drivers/nvidia-drivers-180*
	!=x11-drivers/nvidia-drivers-185*
	!=x11-drivers/nvidia-drivers-190.18
	!=x11-drivers/nvidia-drivers-190.25
	!=x11-drivers/nvidia-drivers-190.32
	!=x11-drivers/nvidia-drivers-190.36
	!=x11-drivers/nvidia-drivers-190.40"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=x11-proto/dri2proto-2.2
	doc? ( app-doc/doxygen
		media-gfx/graphviz
		dev-tex/pdftex )"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		$(use_enable doc documentation) \
		--with-module-dir=/usr/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
	find "${D}" -name '*.la' -exec rm -f '{}' +
}
