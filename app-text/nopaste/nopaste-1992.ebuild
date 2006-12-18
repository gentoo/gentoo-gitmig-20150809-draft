# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/nopaste/nopaste-1992.ebuild,v 1.3 2006/12/18 16:24:35 agriffis Exp $

DESCRIPTION="command-line interface to rafb.net/paste"
HOMEPAGE="http://gentoo.org/~agriffis/nopaste/"
SRC_URI="${HOMEPAGE}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc-fbsd x86 x86-fbsd"
IUSE="X"

DEPEND=""
RDEPEND="${DEPEND}
	dev-lang/ruby
	X? ( || ( x11-misc/xclip x11-misc/xcut ) )"

S=${WORKDIR}

src_install() {
	newbin ${DISTDIR}/${P} ${PN}
}
