# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-visualization/gfsview/gfsview-0.4.2.ebuild,v 1.2 2007/07/15 02:36:19 mr_bones_ Exp $

inherit eutils

DESCRIPTION="GfsView is a graphical viewer for Gerris simulation files."
HOMEPAGE="http://gfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/gfs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""
DEPEND=">=x11-libs/gtkglext-1.0.6
	>=x11-libs/gtk+-2.4.0
	>=sci-libs/gerris-0.8.0"

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
}
