# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme/tango-icon-theme-0.7.1.ebuild,v 1.4 2006/04/23 02:58:43 compnerd Exp $

DESCRIPTION="SVG icon theme from the Tango project"
HOMEPAGE="http://tango-project.org/"
SRC_URI="http://tango-project.org/releases/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE="png"

RDEPEND=">=x11-misc/icon-naming-utils-0.7.0
	 media-gfx/imagemagick
	 >=gnome-base/librsvg-2.12"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

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
