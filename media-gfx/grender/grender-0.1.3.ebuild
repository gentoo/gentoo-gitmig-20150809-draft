# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/grender/grender-0.1.3.ebuild,v 1.3 2004/07/19 09:57:29 eradicator Exp $

IUSE=""

MY_PN="GRender"
MY_P="${MY_PN}-${PV}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="grender is aa queue management system for rendering in Maya."
HOMEPAGE="http://grender.sourceforge.net/"
SRC_URI="mirror://sourceforge/grender/GRender-0.1.3.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

DEPEND=">=x11-libs/gtk+-2.2
	media-gfx/maya"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
