# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdmtheme/kdmtheme-1.1.ebuild,v 1.2 2006/05/30 04:46:22 josejx Exp $

inherit kde

DESCRIPTION="KDM Theme Manager is a Control Center module for changing KDM theme"
HOMEPAGE="http://beta.smileaf.org/"
SRC_URI="http://beta.smileaf.org/files/kdmtheme/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

IUSE=""
SLOT="0"

need-kde 3.4

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README

}
