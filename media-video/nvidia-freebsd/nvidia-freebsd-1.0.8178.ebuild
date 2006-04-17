# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-freebsd/nvidia-freebsd-1.0.8178.ebuild,v 1.1 2006/04/17 10:20:36 flameeyes Exp $

inherit eutils multilib versionator

NV_V="${PV/1.0./1.0-}"
X86_FBSD_NV_PACKAGE="NVIDIA-FreeBSD-x86-${NV_V}"

DESCRIPTION="NVIDIA X11 driver and GLX libraries"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="http://download.nvidia.com/freebsd/${NV_V}/${X86_FBSD_NV_PACKAGE}.tar.gz"

LICENSE="NVIDIA"
SLOT="0"

KEYWORDS="-* ~x86-fbsd"

RESTRICT="strip"
IUSE=""

RDEPEND=""

S="${WORKDIR}/${X86_FBSD_NV_PACKAGE}"

# On BSD userland it wants real make command
MAKE="make"

src_install() {
	insinto /boot/modules
	doins ${S}/src/nvidia.kld

	exeinto /boot/modules
	doexe ${S}/src/nvidia.ko
}
