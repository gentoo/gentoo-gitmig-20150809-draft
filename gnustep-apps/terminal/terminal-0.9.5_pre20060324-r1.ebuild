# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/terminal/terminal-0.9.5_pre20060324-r1.ebuild,v 1.7 2011/08/05 11:55:22 ssuominen Exp $

inherit gnustep-2

S=${WORKDIR}/${PN/t/T}

DESCRIPTION="A terminal emulator for GNUstep"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
SLOT="0"
IUSE=""

RDEPEND="!x11-terms/terminal" #376257
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# on Solaris -lutil doesn't exist, which hence doesn't provide forkpty
	epatch "${FILESDIR}"/${P}-solaris.patch
	epatch "${FILESDIR}"/${P}-size_t.patch
	epatch "${FILESDIR}"/${P}-gnustep-base1.15.patch
	# Correct link command for --as-needed
	sed -i -e "s/Terminal_LDFLAGS/ADDITIONAL_TOOL_LIBS/" GNUmakefile || die "sed failed"
}
