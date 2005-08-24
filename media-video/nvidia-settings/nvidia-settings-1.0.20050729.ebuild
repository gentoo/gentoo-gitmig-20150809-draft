# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-1.0.20050729.ebuild,v 1.1 2005/08/24 12:52:58 azarah Exp $

inherit eutils toolchain-funcs multilib

NVIDIA_VERSION="1.0.7664"
S="${WORKDIR}/${PN}-1.0"
DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~azarah/nvidia/${P}.tar.gz"
# Real SRC_URI:  ftp://download.nvidia.com/XFree86/nvidia-settings/

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
IUSE=

DEPEND="virtual/libc
	virtual/x11
	>=x11-libs/gtk+-2"
RDEPEND=">=media-video/nvidia-glx-${NVIDIA_VERSION}
	>=media-video/nvidia-kernel-${NVIDIA_VERSION}"

src_compile() {
	cd ${S}/src/libXNVCtrl
	einfo "Building libXNVCtrl..."
	# This next voodoo is just to work around xmkmf's broken behaviour
	# after the Xorg move to /usr (or I think, as I have not messed
	# with it in ages).
	ln -snf ${ROOT}/usr/include/X11 include
	xmkmf -a || die "Running xmkmf failed!"
	make CCOPTIONS="${CFLAGS}" clean all || die "Building libXNVCtrl failed!"

	cd ${S}
	einfo "Building nVidia-Settings..."
	emake CC=$(tc-getCC) || die "Failed to build nvidia-settings"
}

src_install() {
	# Install the executable
	exeinto /usr/bin
	doexe nvidia-settings

	# Install libXNVCtrl and headers
	insinto "/usr/$(get_libdir)"
	doins src/libXNVCtrl/libXNVCtrl.a
	insinto /usr/include/NVCtrl
	doins src/libXNVCtrl/{NVCtrl,NVCtrlLib}.h

	# Now install documentation
	rm -f doc/Makefile*
	dodoc doc/*
}
