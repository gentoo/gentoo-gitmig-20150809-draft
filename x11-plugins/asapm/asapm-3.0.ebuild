# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-3.0.ebuild,v 1.1 2005/06/20 12:24:58 ka0ttic Exp $

DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE="jpeg"

DEPEND="virtual/x11
	jpeg? ( media-libs/jpeg )"

src_compile() {
	econf $(use_enable jpeg) || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	dobin asapm
	newman asapm.man asapm.1
}
