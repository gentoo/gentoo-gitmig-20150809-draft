# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ktsuss/ktsuss-2.ebuild,v 1.2 2012/05/05 04:53:53 jdhore Exp $

EAPI=4

DESCRIPTION="Graphical version of su written in C and GTK+ 2"
HOMEPAGE="http://ktsuss.googlecode.com/"
SRC_URI="${HOMEPAGE}/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12.11:2
	>=dev-libs/glib-2.16.5:2"
DEPEND="virtual/pkgconfig
	${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install
	dodoc Changelog CREDITS README
}
