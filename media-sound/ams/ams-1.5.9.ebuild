# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ams/ams-1.5.9.ebuild,v 1.2 2003/09/07 00:06:04 msterret Exp $

DESCRIPTION="Alsa Modular Software Synthesizer"
HOMEPAGE="http://alsamodular.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=" >=media-libs/alsa-lib-0.9
         virtual/jack
		 >=x11-libs/qt-3.0.0
		 media-libs/ladspa-sdk"


SRC_URI="http://alsamodular.sourceforge.net/${P}.tar.bz2"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A} || die
	cd ${S}

	epatch ${FILESDIR}/ams-fixMakefile.patch
}

src_compile() {
	make -f make_ams || die "Make failed."
}

src_install() {

	dobin ams

	dodoc README INSTALL THANKS LICENSE

	docinto examples
	dodoc *.ams
}
