# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.6.4.ebuild,v 1.1 2003/06/30 23:14:03 aliz Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="File searcher"
SRC_URI="mirror://sourceforge/glark/${P}.tar.gz"
HOMEPAGE="http://glark.sf.net"
KEYWORDS="~x86 ~sparc "
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
