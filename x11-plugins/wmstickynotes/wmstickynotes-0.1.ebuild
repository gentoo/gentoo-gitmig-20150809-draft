# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmstickynotes/wmstickynotes-0.1.ebuild,v 1.1 2009/02/21 19:05:36 hncaldwell Exp $

DESCRIPTION="A dockapp for keeping small notes around on the desktop."
HOMEPAGE="http://wmstickynotes.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="x11-libs/gtk+"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc README
}
