# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmail/wmail-2.0.ebuild,v 1.6 2004/03/26 23:10:07 aliz Exp $

IUSE=""

DESCRIPTION="wmail (Window Maker docklet email flag)"
SRC_URI="http://www.minet.uni-jena.de/~topical/sveng/wmail/${P}.tar.gz"
HOMEPAGE="http://www.minet.uni-jena.de/~topical/sveng/wmail.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~ppc"

DEPEND="virtual/glibc
	virtual/x11
	>=x11-libs/libdockapp-0.4.0-r1"

src_compile() {

	econf --enable-delt-xpms || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	dobin src/wmail

	dodoc README wmailrc-sample

}

