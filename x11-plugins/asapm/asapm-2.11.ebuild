# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/asapm/asapm-2.11.ebuild,v 1.6 2004/01/04 18:36:45 aliz Exp $

IUSE="jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="APM monitor for AfterStep"
SRC_URI="http://www.tigr.net/afterstep/download/asapm/${P}.tar.gz"
HOMEPAGE="http://www.tigr.net/afterstep/list.pl"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc"

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
