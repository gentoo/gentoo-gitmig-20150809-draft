# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/talkfilters/talkfilters-2.1.ebuild,v 1.3 2004/03/12 09:18:44 mr_bones_ Exp $

DESCRIPTION="convert ordinary English text into text that mimics a stereotyped or otherwise humorous dialect"
SRC_URI="http://www2.dystance.net:8080/software/talkfilters/${P}.tar.gz"
HOMEPAGE="http://www2.dystance.net:8080/software/talkfilters/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="virtual/glibc
	sys-devel/flex"

src_install () {
	einstall || die
	dodoc AUTHORS ChangeLog NEWS README
}
