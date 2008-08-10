# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-video-virtualbox/xf86-video-virtualbox-1.6.4.ebuild,v 1.1 2008/08/10 14:45:33 jokey Exp $

inherit x-modular eutils

MY_P=VirtualBox-${PV}-OSE
DESCRIPTION="VirtualBox video driver"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://www.virtualbox.org/download/${PV}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
		x11-proto/fontsproto
		x11-proto/randrproto
		x11-proto/renderproto
		x11-proto/xextproto
		x11-proto/xineramaproto
		x11-proto/xproto"

S=${WORKDIR}/${MY_P/-OSE/}

src_unpack() {
		unpack ${A}
		cd "${S}"

		# Fix missing makefiles
		epatch "${FILESDIR}/${P}-fix-missing-makefiles.patch"
}

src_compile() {
		# build the user-space tools, warnings are harmless
		./configure --nofatal \
		--disable-xpcom \
		--disable-sdl-ttf \
		--disable-pulse \
		--disable-alsa \
		--build-headless || die "configure failed"
		source ./env.sh

		cd "${S}/src/VBox/Additions/linux/xgraphics"

		MAKE="kmk" emake || die "kmk failed"
}

src_install() {
		cd "${S}/out/linux.${ARCH}/release/bin/additions"
		insinto /usr/lib/xorg/modules/drivers

		if has_version "<x11-base/xorg-server-1.4" ; then
				newins vboxvideo_drv_13.so vboxvideo_drv.so
		else
				newins vboxvideo_drv_14.so vboxvideo_drv.so
		fi
}

pkg_postinst() {
		elog "You need to edit the file /etc/X11/xorg.conf and set:"
		elog ""
		elog "  Driver  \"vboxvideo\""
		elog ""
		elog "in the Graphics device section (Section \"Device\")"
		elog ""
}
