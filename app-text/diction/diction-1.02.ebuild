# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/diction/diction-1.02.ebuild,v 1.7 2003/09/05 22:43:30 msterret Exp $

DESCRIPTION="Diction and style checkers for english and german texts"
HOMEPAGE="http://www.fsf.org/software/diction/diction.html"
SRC_URI="http://ftp.gnu.org/gnu/diction/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-devel/gettext"

src_compile() {
	./configure --prefix=/usr ||die
	emake || die
}

src_install() {
	make prefix=${D}/usr install
}
