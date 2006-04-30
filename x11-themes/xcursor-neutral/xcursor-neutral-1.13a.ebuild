# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/xcursor-neutral/xcursor-neutral-1.13a.ebuild,v 1.2 2006/04/30 17:21:16 genstef Exp $

DESCRIPTION="The standard X.Org mouse cursor with shadows and animations"
HOMEPAGE="http://www.kde-look.org/content/show.php?content=28310"
SRC_URI="http://www.kde-look.org/content/files/28310-neutral-1.13a.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
RDEPEND="x11-libs/libX11
	x11-libs/libXcursor
	=media-libs/libpng-1.2*"
DEPEND="${RDEPEND}
	x11-apps/xcursorgen"
S=${WORKDIR}/neutral

src_install(){
	insinto /usr/share/cursors/xorg-x11/neutral/
	doins -r ${S}/cursors/
	doins ${S}/index.theme
	dodoc ${S}/LICENSE
	dodoc ${S}/COPYRIGHT
}
