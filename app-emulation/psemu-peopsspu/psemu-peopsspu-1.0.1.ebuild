# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-peopsspu/psemu-peopsspu-1.0.1.ebuild,v 1.4 2002/08/06 18:36:16 gerk Exp $

DESCRIPTION="P.E.Op.S Sound Emulation (SPU) PSEmu Plugin"
HOMEPAGE="http://peops.sourceforge.net"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"
DEPEND="app-arch/unzip
	app-misc/fixdos
	x11-libs/gtk+
	sys-devel/automake"
RDEPEND="${DEPEND}"
SRC_URI="http://telia.dl.sourceforge.net/sourceforge/peops/PeopsSpu101.zip"
S=${WORKDIR}/spuPeopsSound

src_unpack() {
	unzip -a ${DISTDIR}/PeopsSpu101.zip
}

src_compile() {
	cd Src
	mv StdAfx.c stdafx.c
	mv StdAfx.h stdafx.h
	mv OSS.H oss.h
	emake CCFLAGS3="${CFLAGS} -fPIC -c -Wall -ffast-math -fomit-frame-pointer" || die
	cd linuxcfg
	tar xvfz spucfg.tar.gz
	crlf .  # convert all files in dir from dos CRLF to unix CR format...
	automake --add-missing
	./configure
	emake || die
	mv src/spucfg src/cfgPeopsOSS
}

src_install () {
	insinto /usr/lib/psemu/plugins
	doins Src/libspu*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	insinto /usr/lib/psemu/cfg
	doins Src/linuxcfg/src/cfgPeopsOSS
	chmod 755 ${D}/usr/lib/psemu/cfg/*
	dodoc Src/License.txt Src/changelog.txt
	dodoc readme_1_1.txt version_1_1.txt
}

