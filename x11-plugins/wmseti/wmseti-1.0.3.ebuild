# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmseti/wmseti-1.0.3.ebuild,v 1.7 2005/11/11 11:01:00 s4t4n Exp $

IUSE=""

DESCRIPTION="WMaker DockApp to see the progress of work unit analysis for the Seti@Home project."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

HOMEPAGE="http://wmseti.sourceforge.net/"

SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~amd64"
LICENSE="GPL-2"

DEPEND="virtual/x11"

src_install () {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
