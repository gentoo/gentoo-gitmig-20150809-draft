# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ripperx/ripperx-2.3.ebuild,v 1.8 2004/01/21 07:49:33 raker Exp $

MY_P=${P/x/X}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RipperX is a program to rip CD and enconde mp3s"
HOMEPAGE="http://ripperx.sf.net/"
SRC_URI="http://telia.dl.sourceforge.net/ripperx/${MY_P}.tar.gz"
DEPEND="=x11-libs/gtk+-1.2*
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"


src_unpack () {
	unpack ${A}
}

src_compile () {
	cd ${S}
	./configure
	emake || die
}


src_install () {
	cd ${S}/src
	into /usr
	dobin ripperX

	cd ${S}/plugins
	into /usr
	dobin ripperX_plugin-8hz-mp3 ripperX_plugin-bladeenc \
	ripperX_plugin-cdparanoia ripperX_plugin-encode ripperX_plugin-gogo \
	ripperX_plugin-l3enc ripperX_plugin-lame ripperX_plugin-mp3enc \
	ripperX_plugin-oggenc ripperX_plugin-xingmp3enc ripperX_plugin_tester

	dodoc README AUTHORS COPYING BUGS CHANGES FAQ TODO
}
