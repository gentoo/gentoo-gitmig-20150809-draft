# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/festival-freebsoft-utils/festival-freebsoft-utils-0.2.ebuild,v 1.6 2005/01/01 10:47:48 eradicator Exp $

DESCRIPTION="a collection of Festival functions for speech-dispatcher"
HOMEPAGE="http://www.freebsoft.org/festival-freebsoft-utils"
SRC_URI="http://www.freebsoft.org/pub/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND=">=app-accessibility/festival-1.4.3"

src_compile(){
	einfo "Nothing to compile."
}

src_install() {
	insinto /usr/lib/festival
	doins ${S}/*.scm
}
