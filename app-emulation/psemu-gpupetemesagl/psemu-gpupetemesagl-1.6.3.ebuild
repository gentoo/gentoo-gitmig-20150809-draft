# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-gpupetemesagl/psemu-gpupetemesagl-1.6.3.ebuild,v 1.6 2002/10/20 18:37:51 vapier Exp $

DESCRIPTION="PSEmu OpenGL GPU"
HOMEPAGE="http://home.t-online.de/home/PeteBernert"
LICENSE="freedist"
KEYWORDS="x86 -ppc"
SLOT="0"    
DEPEND="virtual/opengl"
SRC_URI="http://www.ngemu.com/psx/plugins/linux/gpu/gpupetemesagl163.tar.gz"
S=${WORKDIR}

src_install () {
	insinto /usr/lib/psemu/plugins
	doins lib*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	insinto /usr/lib/psemu/cfg
	doins cfgPeteMesaGL
	chmod 755 ${D}/usr/lib/psemu/cfg/*
	dodoc readme.txt version.txt
}
