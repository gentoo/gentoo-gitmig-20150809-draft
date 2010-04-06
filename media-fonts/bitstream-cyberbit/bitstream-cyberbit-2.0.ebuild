# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/bitstream-cyberbit/bitstream-cyberbit-2.0.ebuild,v 1.2 2010/04/06 10:11:03 phajdan.jr Exp $

EAPI="2"

inherit font

DESCRIPTION="Cyberbit Unicode (including CJK) font"
HOMEPAGE="http://www.bitstream.com/"
SRC_URI="http://http.netscape.com.edgesuite.net/pub/communicator/extras/fonts/windows/Cyberbit.ZIP -> ${P}.zip"
LICENSE="BitstreamCyberbit"

SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="bindist mirror"

FONT_SUFFIX="ttf"
