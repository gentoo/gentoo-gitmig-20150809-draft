# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/cellwriter/cellwriter-1.3.4.ebuild,v 1.4 2011/03/28 19:11:34 ssuominen Exp $

EAPI=2

DESCRIPTION="Grid-entry natural handwriting input panel"
HOMEPAGE="http://risujin.org/cellwriter/"
SRC_URI="http://pub.risujin.org/cellwriter/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="gnome"

RDEPEND="x11-libs/libXtst
	>=x11-libs/gtk+-2.10:2
	gnome? ( gnome-base/libgnome )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/inputproto"

src_configure() {
	econf $(use_with gnome)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
