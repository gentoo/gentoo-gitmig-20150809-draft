# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/terminal/terminal-0.9.7.ebuild,v 1.1 2010/05/25 22:34:14 voyageur Exp $

EAPI=2

inherit gnustep-2

S=${WORKDIR}/${P/t/T}

DESCRIPTION="A terminal emulator for GNUstep"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="http://savannah.nongnu.org/download/gap/${P/t/T}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
SLOT="0"
IUSE=""

src_prepare() {
	# Correct link command for --as-needed
	sed -i -e "s/Terminal_LDFLAGS/ADDITIONAL_TOOL_LIBS/" GNUmakefile || die "sed failed"
}
