# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/yydecode/yydecode-0.2.10.ebuild,v 1.5 2004/11/12 18:50:19 blubb Exp $

DESCRIPTION="A decoder for yENC format, popular on Usenet"
HOMEPAGE="http://yydecode.sourceforge.net/"
SRC_URI="mirror://sourceforge/yydecode/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc alpha ~arm ~amd64"
IUSE=""

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
