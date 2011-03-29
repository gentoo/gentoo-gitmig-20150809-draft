# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/ktsuss/ktsuss-1.4.ebuild,v 1.8 2011/03/29 13:03:59 angelos Exp $

EAPI=1

DESCRIPTION="ktsuss: keep the su simple, stupid. Graphical version of su written
in C and GTK+ 2"
HOMEPAGE="http://developer.berlios.de/projects/ktsuss/"
SRC_URI="mirror://berlios//${PN}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12.11:2
	>=dev-libs/glib-2.16.5:2"
DEPEND="dev-util/pkgconfig
	${RDEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc Changelog CREDITS README
}
