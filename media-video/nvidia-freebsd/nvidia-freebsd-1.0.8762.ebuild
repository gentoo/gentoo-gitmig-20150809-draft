# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-freebsd/nvidia-freebsd-1.0.8762.ebuild,v 1.1 2006/05/23 17:48:02 flameeyes Exp $

inherit eutils multilib versionator toolchain-funcs portability

NV_V="$(replace_version_separator 2 -)"
X86_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86-${NV_V}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/freebsd/${NV_V}/${X86_FBSD_NV_PACKAGE}.tar.gz"

LICENSE="NVIDIA"
SLOT="0"

KEYWORDS="-* ~x86-fbsd"

RESTRICT="nostrip"
IUSE=""

RDEPEND=""

S="${WORKDIR}/${X86_FBSD_NV_PACKAGE}"

QA_TEXTRELS="/boot/modules/nvidia.ko /boot/modules/nvidia.kld"

src_compile() {
	MAKE="$(get_bmake)" emake CC="$(tc-getCC)" LD="$(tc-getLD)"
}

src_install() {
	insinto /boot/modules
	doins "${S}/src/nvidia.kld"

	exeinto /boot/modules
	doexe "${S}/src/nvidia.ko"
}
