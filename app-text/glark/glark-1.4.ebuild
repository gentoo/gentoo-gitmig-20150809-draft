# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.4.ebuild,v 1.5 2002/10/04 05:05:19 vapier Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="File searcher"
SRC_URI="http://belnet.dl.sourceforge.net/sourceforge/glark/${P}.tar.gz"
HOMEPAGE="http://glark.sf.net"
KEYWORDS="x86 sparc sparc64"
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
