# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/stldb4/stldb4-0.3.13.ebuild,v 1.2 2005/08/16 04:43:58 vapier Exp $

inherit flag-o-matic

DESCRIPTION="a nice C++ wrapper for db4"
HOMEPAGE="http://witme.sourceforge.net/libferris.web/"
SRC_URI="mirror://sourceforge/witme/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-libs/ferrisloki-2.0.3
	>=dev-libs/libferrisstreams-0.3.6
	dev-libs/STLport"

fsrc_unpack() {
	unpack ${A}
	cd ${S}
	ln -s ${S}/db-4.1.25/dist STLdb4
	append-flags -I${S}
}

src_compile() {
	econf --enable-wrapdebug --enable-rpc --with-uniquename=stldb4 || die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README
}
