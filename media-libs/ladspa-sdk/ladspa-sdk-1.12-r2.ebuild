# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ladspa-sdk/ladspa-sdk-1.12-r2.ebuild,v 1.8 2004/11/21 21:29:23 eradicator Exp $

inherit eutils

IUSE=""

MY_PN=${PN/-/_}
MY_P=${MY_PN}_${PV}
S=${WORKDIR}/${MY_PN}/src

DESCRIPTION="The Linux Audio Developer's Simple Plugin API and some example plugins"
SRC_URI="http://www.ladspa.org/download/${MY_P}.tgz"
HOMEPAGE="http://www.ladspa.org/"

SLOT="0"
LICENSE="LGPL-2.1"

KEYWORDS="x86 ~ppc sparc ~alpha amd64 ~ppc-macos"

DEPEND="virtual/libc
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i \
		-e "/^CFLAGS/ s:-O3:${CFLAGS}:" ${S}/makefile || \
			die "sed makefile failed (CFLAGS)"
	sed -i s:-mkdirhier:mkdir\ -p:g ${S}/makefile || \
			die "sed makefile failed (mkdirhier)"
	epatch ${FILESDIR}/${P}-test.patch
	use ppc-macos && epatch ${FILESDIR}/${P}-ppc-macos.patch
}

src_compile() {
	emake -j1 targets || die
}

src_test() {
	# needed for sox to allow playback of the test sounds
	addwrite /dev/dsp

	emake test || die
}

src_install() {
	make \
		INSTALL_PLUGINS_DIR=${D}/usr/$(get_libdir)/ladspa \
		INSTALL_INCLUDE_DIR=${D}/usr/include \
		INSTALL_BINARY_DIR=${D}/usr/bin \
		install || die "make install failed"

	cd ../doc && \
		dohtml *.html || die "dohtml failed"

	# Needed for apps like rezound
	dodir /etc/env.d
	echo "LADSPA_PATH=/usr/$(get_libdir)/ladspa" > ${D}/etc/env.d/60ladspa
}
