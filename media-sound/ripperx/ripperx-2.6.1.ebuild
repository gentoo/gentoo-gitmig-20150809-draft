# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ripperx/ripperx-2.6.1.ebuild,v 1.1 2004/01/21 07:49:33 raker Exp $

MY_P=${P/x/X}
S=${WORKDIR}/${MY_P}
DESCRIPTION="RipperX is a program to rip CD and enconde mp3s"
HOMEPAGE="http://ripperx.sf.net/"
SRC_URI="mirror://sourceforge/ripperx/${MY_P}.tar.gz"

DEPEND="=x11-libs/gtk+-1.2*
	media-sound/lame
	media-sound/cdparanoia
	media-libs/id3lib
	media-libs/flac"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

src_install () {
	dodoc CHANGES COPYING FAQ INSTALL README* TODO

	into /usr
	dobin src/ripperX plugins/ripperX_plugin-8hz-mp3 \
	plugins/ripperX_plugin-bladeenc plugins/ripperX_plugin-cdparanoia \
	plugins/ripperX_plugin-encode plugins/ripperX_plugin-gogo plugins/ripperX_plugin-l3enc \
	plugins/ripperX_plugin-lame plugins/ripperX_plugin-mp3enc plugins/ripperX_plugin-oggenc \
	plugins/ripperX_plugin-xingmp3enc plugins/ripperX_plugin_tester \
	plugins/ripperX_plugin-flac
}
