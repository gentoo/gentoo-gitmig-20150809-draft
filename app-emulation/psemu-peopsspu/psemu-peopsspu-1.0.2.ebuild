# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-peopsspu/psemu-peopsspu-1.0.2.ebuild,v 1.2 2003/02/13 07:16:15 vapier Exp $

DESCRIPTION="P.E.Op.S Sound Emulation (SPU) PSEmu Plugin"
HOMEPAGE="http://peops.sourceforge.net/"
SRC_URI="mirror://sourceforge/peops/PeopsSpu${PV//./}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"

DEPEND="app-arch/unzip
	app-misc/fixdos
	x11-libs/gtk+
	sys-devel/automake"

S=${WORKDIR}

src_compile() {
	cd src
	emake CCFLAGS3="${CFLAGS} -fPIC -c -Wall -ffast-math -fomit-frame-pointer" || die

	cd linuxcfg
	tar xvfz spucfg.tar.gz
	crlf .  # convert all files in dir from dos CRLF to unix CR format...
	emake distclean || die "could not clean up"
	automake --add-missing || die "could not automake"
	econf
	emake || die
	mv src/spucfg src/cfgPeopsOSS
}

src_install () {
	insinto /usr/lib/psemu/plugins
	doins src/libspu*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	insinto /usr/lib/psemu/cfg
	doins src/linuxcfg/src/cfgPeopsOSS
	chmod 755 ${D}/usr/lib/psemu/cfg/*
	dodoc src/*.txt *.txt
}
