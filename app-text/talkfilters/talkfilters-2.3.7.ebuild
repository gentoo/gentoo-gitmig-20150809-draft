# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.3.7.ebuild,v 1.1 2007/08/12 17:31:39 pva Exp $

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
HOMEPAGE="http://www.hyperrealm.com/talkfilters/talkfilters.html"
SRC_URI="http://www.hyperrealm.com/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~ppc-macos ~x86"
IUSE=""

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README
}
