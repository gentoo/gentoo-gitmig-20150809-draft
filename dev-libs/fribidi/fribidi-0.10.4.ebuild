# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/fribidi/fribidi-0.10.4.ebuild,v 1.1 2003/04/01 20:32:54 danarmak Exp $

DESCRIPTION="library implementing the Unicode Bidirectional Algorithm"
HOMEPAGE="http://fribidi.sourceforge.net"
SRC_URI="mirror://sourceforge/fribidi/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
S="${WORKDIR}/${P}"

src_compile() {
	econf
	emake || die
	make test || die
}

src_install() {
	einstall || die
}
