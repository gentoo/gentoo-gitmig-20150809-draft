# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/psemu-peopsspu/psemu-peopsspu-1.0.5.ebuild,v 1.1 2003/03/10 10:07:09 vapier Exp $

inherit eutils

DESCRIPTION="P.E.Op.S Sound Emulation (SPU) PSEmu Plugin"
HOMEPAGE="http://peops.sourceforge.net/"
SRC_URI="mirror://sourceforge/peops/PeopsSpu${PV//./}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 -ppc"
SLOT="0"
IUSE="alsa oss"

DEPEND="alsa? ( media-libs/alsa-lib )
	app-arch/unzip
	=x11-libs/gtk+-1*
	sys-devel/automake"

S=${WORKDIR}

src_unpack() {
	unpack ${A}

	cd src/linuxcfg
	tar -zxf spucfg.tar.gz
	cd ${S}
	edos2unix `find -name '*.in' -o -name '*.am' -o -name '*.[ch]' -o -name 'config*'`

	cd src/linuxcfg
	( automake --add-missing && emake distclean ) \
		> /dev/null || die "could not clean up"
}

src_compile() {
	rm libspu*
	cd src
	if [ `use oss` ] || [ -z "`use oss``use alsa`" ] ; then
		emake clean || die
		emake USEALSA=FALSE CCFLAGS3="${CFLAGS} -fPIC -c -Wall -ffast-math -fomit-frame-pointer" || die
		mv libspu* ..
	fi
	if [ `use alsa` ] ; then
		emake clean || die
		emake USEALSA=TRUE CCFLAGS3="${CFLAGS} -fPIC -c -Wall -ffast-math -fomit-frame-pointer" || die
		mv libspu* ..
	fi

	cd linuxcfg
	econf || die
	emake || die
	mv src/spucfg src/cfgPeopsOSS
}

src_install() {
	insinto /usr/lib/psemu/plugins
	doins libspu*
	chmod 755 ${D}/usr/lib/psemu/plugins/*
	insinto /usr/lib/psemu/cfg
	doins src/linuxcfg/src/cfgPeopsOSS
	chmod 755 ${D}/usr/lib/psemu/cfg/*
	dodoc src/*.txt *.txt
}
