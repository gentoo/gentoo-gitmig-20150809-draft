# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ferite/ferite-0.99.6.ebuild,v 1.10 2005/04/24 03:10:47 hansmi Exp $

DESCRIPTION="A clean, lightweight, object oriented scripting language"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ferite.org/"

DEPEND="virtual/libc
	dev-libs/libpcre
	dev-libs/libxml2"

SLOT="1"
LICENSE="as-is"
KEYWORDS="x86 sparc ppc amd64"
IUSE=""

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README*
	dohtml -r docs
}
