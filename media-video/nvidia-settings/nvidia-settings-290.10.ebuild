# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-290.10.ebuild,v 1.1 2011/12/04 13:54:48 jlec Exp $

EAPI=4

inherit eutils flag-o-matic multilib toolchain-funcs

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="ftp://download.nvidia.com/XFree86/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86 ~x86-fbsd"
IUSE=""

# xorg-server is used in the depends as nvidia-settings builds against some
# headers in /usr/include/xorg/.
# This also allows us to optimize out a lot of the other dependancies, as
# between gtk and xorg-server, almost all libraries and headers are accounted
# for.
DEPEND="
	dev-util/pkgconfig
	x11-base/xorg-server
	x11-libs/gtk+:2
	x11-libs/libXt
	x11-libs/libXv
	x11-libs/pango[X]
	x11-proto/xf86driproto
	x11-proto/xf86vidmodeproto"

RDEPEND="
	x11-base/xorg-server
	x11-libs/gtk+:2
	x11-libs/libXt
	x11-libs/pango[X]
	x11-drivers/nvidia-drivers"

src_prepare() {
	sed -i -e "s#prefix = .*#prefix = ${D}/usr#" utils.mk || die
}

src_compile() {
	einfo "Building libXNVCtrl..."
	cd "${S}/src/libXNVCtrl"
	emake clean
	append-flags -fPIC
	emake CDEBUGFLAGS="${CFLAGS}" CC="$(tc-getCC)" libXNVCtrl.a
	filter-flags -fPIC

	# cd "${S}"
	#einfo "Building nVidia-Settings..."
	#emake  CC="$(tc-getCC)" STRIP_CMD=/bin/true || die "Failed to build nvidia-settings"
}

src_install() {
	#emake STRIP_CMD=/bin/true install || die

	# Install libXNVCtrl and headers
	insinto "/usr/$(get_libdir)"
	doins src/libXNVCtrl/libXNVCtrl.a
	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/{NVCtrl,NVCtrlLib}.h

	# Install icon and .desktop entry
	#doicon "${FILESDIR}/icon/${PN}.png"
	#domenu "${FILESDIR}/icon/${PN}.desktop"

	# Now install documentation
	dodoc doc/*.txt
}
