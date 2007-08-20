# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libwpd/libwpd-0.8.10.ebuild,v 1.1 2007/08/20 16:51:43 dang Exp $

inherit eutils

DESCRIPTION="WordPerfect Document import/export library"
HOMEPAGE="http://libwpd.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="doc"
RESTRICT="test"

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
	emake DESTDIR=${D} install || die
	dodoc CHANGES CREDITS INSTALL README TODO
}
