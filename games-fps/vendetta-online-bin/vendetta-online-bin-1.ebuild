# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/vendetta-online-bin/vendetta-online-bin-1.ebuild,v 1.3 2004/12/01 06:44:18 warpzero Exp $

inherit eutils games

S=${WORKDIR}
DESCRIPTION="Space-based MMORPG with amazing graphics"
HOMEPAGE="http://www.vendetta-online.com/"
SRC_URI="vendetta-linux-installer.sh"

RESTRICT="nomirror fetch"
LICENSE="guild"
KEYWORDS="-* ~x86 ~amd64"
IUSE=""
SLOT="0"

RDEPEND="virtual/x11
	virtual/opengl
	=x11-libs/gtk+-1.2*
	amd64? ( =app-emulation/emul-linux-x86-gtklibs-1.2* )"

pkg_nofetch() {
	einfo "You need to download ${A} from Guild Software by:"
	einfo "1. Going to http://www.vendetta-online.com/ and creating your login"
	einfo "2. Obtain ${A} from your CD"
	einfo " OR"
	einfo "2. Login to VO's website on the top-left under \"Web\","
	einfo "   and then downloading it from the \"Download\" link"
	einfo "   under \"Game\" on the left pane."
	einfo "3. Put ${A} in ${DISTDIR}"
	einfo "4. emerge vendetta-online-bin"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dogamesbin vendetta || die "dogamesbin failed"
	prepgamesdirs
}
