# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.71.ebuild,v 1.1 2003/07/16 01:41:42 vapier Exp $

DESCRIPTION="PSEmu MesaGL GPU"
HOMEPAGE="http://home.t-online.de/home/PeteBernert/"
SRC_URI="http://www.ngemu.com/psx/plugins/linux/gpu/gpupetemesagl${PV//.}.tar.gz"

LICENSE="freedist"
KEYWORDS="-* x86"
SLOT="0"

DEPEND="virtual/opengl"

S=${WORKDIR}

src_install() {
	exeinto /usr/lib/psemu/plugins
	doexe lib*
	exeinto /usr/lib/psemu/cfg
	doexe cfgPeteMesaGL
	insinto /usr/lib/psemu/cfg
	doins gpuPeteMesaGL.cfg
	dodoc readme.txt version.txt
}
