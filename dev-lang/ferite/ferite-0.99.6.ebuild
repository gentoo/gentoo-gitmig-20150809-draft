# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ferite/ferite-0.99.6.ebuild,v 1.1 2003/02/09 22:43:03 mholzer Exp $

DESCRIPTION="A clean, lightweight, object oriented scripting language"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ferite.org/"

DEPEND="virtual/glibc
	dev-libs/libpcre
	dev-libs/libxml2"

SLOT="1"
LICENSE="as-is"
KEYWORDS="~x86 ~sparc ~ppc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog README*
	dohtml -r docs
}
