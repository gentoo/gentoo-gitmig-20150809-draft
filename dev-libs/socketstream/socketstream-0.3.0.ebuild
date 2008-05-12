# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/socketstream/socketstream-0.3.0.ebuild,v 1.7 2008/05/12 01:33:10 halcy0n Exp $

DESCRIPTION="C++ Streaming sockets library"
SRC_URI="mirror://sourceforge/socketstream/${P}.tar.gz"
HOMEPAGE="http://socketstream.sourceforge.net/"

SLOT="0"

LICENSE="LGPL-2"
KEYWORDS="~x86 alpha ~ppc ~sparc ~hppa amd64"
IUSE=""

DEPEND=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog NEWS README TODO
}
