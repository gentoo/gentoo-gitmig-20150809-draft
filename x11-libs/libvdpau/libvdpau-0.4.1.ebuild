# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libvdpau/libvdpau-0.4.1.ebuild,v 1.1 2010/09/09 18:23:59 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="VDPAU wrapper and trace libraries"
HOMEPAGE="http://www.freedesktop.org/wiki/Software/VDPAU"
SRC_URI="http://people.freedesktop.org/~aplattner/vdpau/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="doc"

#unfortunately, there's driver versions in between that this works with
RDEPEND="x11-libs/libX11
	!=x11-drivers/nvidia-drivers-180.29
	!=x11-drivers/nvidia-drivers-180.60
	!=x11-drivers/nvidia-drivers-185.18.14
	!=x11-drivers/nvidia-drivers-185.18.29
	!=x11-drivers/nvidia-drivers-185.18.31
	!=x11-drivers/nvidia-drivers-185.18.36
	!=x11-drivers/nvidia-drivers-190.18
	!=x11-drivers/nvidia-drivers-190.25
	!=x11-drivers/nvidia-drivers-190.32
	!=x11-drivers/nvidia-drivers-190.36
	!=x11-drivers/nvidia-drivers-190.40"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto
	doc? ( app-doc/doxygen
		media-gfx/graphviz
		dev-tex/pdftex )"

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		--disable-dependency-tracking \
		--with-module-dir=/usr/$(get_libdir)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog
}
