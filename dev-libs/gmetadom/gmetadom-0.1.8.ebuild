# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gmetadom/gmetadom-0.1.8.ebuild,v 1.2 2004/06/24 23:11:28 agriffis Exp $

DESCRIPTION="A library providing bindings for multiple languages of multiple C DOM implementations"
HOMEPAGE="http://gmetadom.sourceforge.net/"
SRC_URI="mirror://sourceforge/gmetadom/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-libs/gdome2-0.7.4"
DEPEND="${RDEPEND}
	>=dev-ml/findlib-0.8
	>=dev-libs/libxslt-1.0.0"

src_compile() {
	econf || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS BUGS ChangeLog HISTORY LICENSE NEWS README
}
