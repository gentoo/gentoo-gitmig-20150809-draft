# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $

IUSE=""

MY_PN=${PN/-/_}
MY_P=${MY_PN}_${PV}
S=${WORKDIR}/${MY_PN}/src

DESCRIPTION="The Linux Audio Developer's Simple Plugin API and some example plugins"
SRC_URI="http://www.ladspa.org/download/${MY_P}.tgz"
HOMEPAGE="http://www.ladspa.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc sparc "

DEPEND="virtual/glibc
		media-sound/alsa-driver"
src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -e "/^CFLAGS/ s/-O3/${CFLAGS}/" < makefile > makefile.hacked
	mv makefile.hacked makefile
}

src_compile() {
	make targets || die
}

src_install() {
	make \
		INSTALL_PLUGINS_DIR=${D}/usr/lib/ladspa \
		INSTALL_INCLUDE_DIR=${D}/usr/include \
		INSTALL_BINARY_DIR=${D}/usr/bin \
		install || die

	dodoc ../doc/*
}
