# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/dav/dav-0.8.4.ebuild,v 1.2 2004/03/13 23:00:56 mr_bones_ Exp $

DESCRIPTION="A minimal console text editor"
HOMEPAGE="http://dav-text.sourceforge.net/"

# The maintainer does not keep sourceforge's mirrors up-to-date,
# so we point to the website's store of files.
SRC_URI="http://dav-text.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
