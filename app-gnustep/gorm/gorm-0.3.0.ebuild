# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/gorm/gorm-0.3.0.ebuild,v 1.1 2003/07/30 18:59:31 raker Exp $

inherit base gnustep

S=${WORKDIR}/${P/g/G}
A=${P/g/G}.tar.gz

DESCRIPTION="GNUstep GUI interface designer"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/dev-apps/${P/g/G}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
DEPEND=">=dev-util/gnustep-gui-0.8.5"
