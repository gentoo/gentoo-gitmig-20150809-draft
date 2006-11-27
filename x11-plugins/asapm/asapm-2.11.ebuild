# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-2.11.ebuild,v 1.10 2006/11/27 13:14:08 gustavoz Exp $

IUSE="jpeg"

DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc -sparc x86"

DEPEND="virtual/x11
	jpeg? ( media-libs/jpeg )"

src_compile() {
	econf `use_enable jpeg` || die
	emake || die
}

src_install () {
	dobin asapm
	newman asapm.man asapm.1
}
