# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/vendetta-test/vendetta-test-0.ebuild,v 1.5 2004/12/01 04:52:31 vapier Exp $

inherit eutils games

DESCRIPTION="A testbed for a space-based MMORPG with amazing graphics"
HOMEPAGE="http://www.guildsoftware.com/test.html"
SRC_URI="vendetta-linux-installer.sh"

LICENSE="guild"
SLOT="0"
KEYWORDS="-* x86"
IUSE=""
RESTRICT="nomirror fetch"

RDEPEND="virtual/x11
	virtual/opengl
	=x11-libs/gtk+-1.2*"

S=${WORKDIR}

pkg_nofetch() {
	einfo "Please download ${A} from Guild Software"
	einfo "by doing the following:"
	einfo "1. Goto http://www.guildsoftware.com/test.participating.html"
	einfo "2. Click the Create an Account link near the bottom of the page"
	einfo
	einfo "After creating your account, click on the Download link on"
	einfo "the left side of the page"
	einfo
	einfo "3. Read and agree to the license"
	einfo "4. Select Linux under the Which platform are you running? selector"
	einfo "5. Click the Proceed to download button"
	einfo "6. Download the vendetta-linux-installer.sh from the link on that page"
}

src_unpack() {
	unpack_makeself
}

src_install() {
	dogamesbin vendetta
	prepgamesdirs
}
