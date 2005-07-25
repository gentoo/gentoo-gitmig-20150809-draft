# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.8.2.ebuild,v 1.1 2005/07/25 12:57:40 hanno Exp $

inherit eutils

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2
	>=gnome-extra/libgsf-1.6
	doc? ( app-doc/doxygen )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	econf $(use_with doc docs) || die
	emake || die
}

src_install() {
	einstall || die
	dodoc CHANGES COPYING CREDITS INSTALL README TODO
}
