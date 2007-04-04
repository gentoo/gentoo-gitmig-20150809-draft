# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellflynn/gkrellflynn-0.7.ebuild,v 1.9 2007/04/04 17:09:03 gustavoz Exp $

inherit gkrellm-plugin

IUSE=""
HOMEPAGE="http://horus.comlab.uni-rostock.de/flynn/"
SRC_URI="http://horus.comlab.uni-rostock.de/flynn/${P}.tar.gz"
DESCRIPTION="A funny GKrellM2 load monitor (for Doom(tm) fans)"
KEYWORDS="alpha ~amd64 ppc sparc x86"
SLOT="0"
LICENSE="GPL-2"

src_compile() {
	# Clean out precompiled plugin first
	make clean
	make gkrellm2
}

