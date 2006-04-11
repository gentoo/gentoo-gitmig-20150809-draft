# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/scw/scw-0.4.3.ebuild,v 1.2 2006/04/11 16:55:49 swegener Exp $

DESCRIPTION="A GTK+ widget set specifically designed for chat programs."
HOMEPAGE="http://corrie.scp.fi/users/kalle.vahlman/scw/"
SRC_URI="http://corrie.scp.fi/users/kalle.vahlman/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc
	sys-devel/libtool
	dev-util/pkgconfig
	>=dev-libs/glib-2.4
	>=x11-libs/gtk+-2.4"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README NEWS ChangeLog AUTHORS
}
