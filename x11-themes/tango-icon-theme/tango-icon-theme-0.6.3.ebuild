# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.6.3.ebuild,v 1.1 2005/12/29 04:27:37 metalgod Exp $

DESCRIPTION="SVG icon theme from the Tango project"
HOMEPAGE="http://tango-project.org/"
SRC_URI="http://tango-project.org/releases/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="png"

RDEPEND=">=x11-misc/icon-naming-utils-0.6
	 media-gfx/imagemagick
	 gnome-base/librsvg"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	if use png; then
	econf --enable-png-creation || die "configure failed"
	else
	econf || die "configure failed"
	fi

	emake || die "make failed"
}
src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING NEWS README
}
