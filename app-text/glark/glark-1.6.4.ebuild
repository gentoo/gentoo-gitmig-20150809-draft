# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.6.4.ebuild,v 1.3 2004/03/05 18:42:15 gustavoz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="File searcher"
SRC_URI="mirror://sourceforge/glark/${P}.tar.gz"
HOMEPAGE="http://glark.sf.net"
KEYWORDS="x86 sparc"
LICENSE="LGPL-2.1"
DEPEND=">=dev-lang/ruby-1.6.7"
RDEPEND="$DEPEND"
SLOT="0"

src_compile() {
	emake || die
}

src_install () {
	dobin glark
	doman glark.1
}
