# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdmtheme/kdmtheme-1.1.2.ebuild,v 1.1 2006/09/02 11:18:05 nelchael Exp $

inherit kde

DESCRIPTION="KDM Theme Manager is a Control Center module for changing KDM theme"
HOMEPAGE="http://beta.smileaf.org/"
SRC_URI="http://beta.smileaf.org/files/kdmtheme/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""
SLOT="0"

need-kde 3.4

src_install() {

	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README

}
