# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-settings/nvidia-settings-1.0.ebuild,v 1.3 2004/07/26 05:09:29 cyfred Exp $

inherit eutils

DESCRIPTION="NVIDIA Linux X11 Settings Utility"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/XFree86/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~x86 ~amd64"
RESTRICT=""
IUSE=""

NVIDIA_VERSION="1.0.6106"

DEPEND="virtual/libc
	virtual/x11
	>=x11-libs/gtk+-2*
	amd64? ( app-arch/bzip2 )"
RDEPEND=">=media-video/nvidia-glx-${NVIDIA_VERSION}
	>=media-video/nvidia-kernel-${NVIDIA_VERSION}"

src_unpack() {
	unpack ${A}

	# libXNVCtrl.a is 32 bit built, fixing thanks augustus
	use amd64 && \
		bzip2 -dc ${FILESDIR}/libXNVCtrl.a.bz2 \
			> ${S}/src/libXNVCtrl/libXNVCtrl.a
}

src_compile() {
	emake || die "Failed to build nvidia-settings"
}

src_install() {
	# Install the executable
	exeinto /usr/bin
	doexe nvidia-settings

	# Now install documentation
	rm -f doc/Makefile*
	dodoc doc/*
}
