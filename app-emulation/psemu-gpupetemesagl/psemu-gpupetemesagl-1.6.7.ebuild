# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.6.7.ebuild,v 1.3 2002/11/18 10:42:46 hanno Exp $

URI_PV=`echo -n ${PV} | sed -e "s:\.::g"`
DESCRIPTION="PSEmu OpenGL GPU"
HOMEPAGE="http://home.t-online.de/home/PeteBernert/"
SRC_URI="http://www.ngemu.com/psx/plugins/linux/gpu/gpupetemesagl${URI_PV}.tar.gz"

LICENSE="freedist"
KEYWORDS="x86 -ppc"
SLOT="0"
IUSE=""

DEPEND="virtual/opengl"
S="${WORKDIR}"

src_install() {
	insinto /usr/lib/psemu/plugins
	doins lib*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	insinto /usr/lib/psemu/cfg
	doins cfgPeteMesaGL
	chmod 755 ${D}/usr/lib/psemu/cfg/*
	dodoc readme.txt version.txt
}
