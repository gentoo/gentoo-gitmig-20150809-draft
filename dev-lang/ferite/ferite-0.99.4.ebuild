# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ferite/ferite-0.99.4.ebuild,v 1.14 2004/07/02 04:25:38 eradicator Exp $

DESCRIPTION="scripting engine and language written in c for complete portability"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.ferite.org/"

DEPEND="virtual/libc
	dev-libs/libpcre
	dev-libs/libxml2"

SLOT="1"
LICENSE="as-is"
KEYWORDS="x86 sparc"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README*
	dohtml -r docs
}
