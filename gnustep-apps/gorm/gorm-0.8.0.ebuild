# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/gorm/gorm-0.8.0.ebuild,v 1.1 2004/09/26 21:17:17 fafhrd Exp $

inherit gnustep

S=${WORKDIR}/${P/g/G}

DESCRIPTION="Gorm is a clone of the NeXTstep Interface Builder application for GNUstep."
HOMEPAGE="http://www.gnustep.org/experience/Gorm.html"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P/g/G}.tar.gz"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

DEPEND="${GS_DEPEND}"
RDEPEND="${GS_RDEPEND}"

