# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.1.ebuild,v 1.8 2004/07/14 00:46:49 agriffis Exp $

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
SRC_URI="http://www2.dystance.net:8080/software/talkfilters/${P}.tar.gz"
HOMEPAGE="http://www2.dystance.net:8080/software/talkfilters/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE=""

DEPEND="virtual/libc
	sys-devel/flex"

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
