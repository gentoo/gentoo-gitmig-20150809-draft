# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gorm/gorm-0.3.0.ebuild,v 1.6 2004/07/22 21:41:25 fafhrd Exp $

inherit base gnustep-old

S=${WORKDIR}/${P/g/G}

DESCRIPTION="GNUstep GUI interface designer"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P/g/G}.tar.gz"
IUSE=""
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"

DEPEND=">=dev-util/gnustep-gui-0.8.5"

src_unpack() {
	unpack ${P/g/G}.tar.gz
	cd ${S}
}
