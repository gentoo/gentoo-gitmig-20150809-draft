# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/naim-modules/naim-modules-0.0.11.7.2.ebuild,v 1.1 2005/01/25 19:12:00 rizzo Exp $

MY_PV="${PV}-2004-07-20-0047"
DESCRIPTION="a bunch of modules for the naim im client"
HOMEPAGE="http://site.n.ml.org/info/naim/"
SRC_URI="http://site.n.ml.org/download/20050124143557/naim/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE=""

DEPEND=">=net-im/naim-0.11.7.3"

S=${WORKDIR}/${PN}-${MY_PV}

src_compile() {
	econf --with-pkgdocdir=/usr/share/doc/${PF} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
