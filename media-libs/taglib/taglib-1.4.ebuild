# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/taglib/taglib-1.4.ebuild,v 1.7 2005/10/31 07:34:02 kloeri Exp $

DESCRIPTION="A library for reading and editing audio meta data"
HOMEPAGE="http://developer.kde.org/~wheeler/taglib.html"
SRC_URI="http://developer.kde.org/~wheeler/files/src/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE="debug"

DEPEND="sys-libs/zlib"

src_compile() {
	econf $(use_enable debug) || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README TODO
}
