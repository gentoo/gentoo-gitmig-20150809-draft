# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-gnustep/terminal/terminal-0.9.4.ebuild,v 1.1 2003/07/16 17:45:50 brain Exp $

inherit gnustep

S=${WORKDIR}/${P/t/T}
A=${P/t/T}.tar.gz

DESCRIPTION="GNUstep GUI interface designer"
HOMEPAGE="http://www.nongnu.org/terminal/"
SRC_URI="http://savannah.nongnu.org/download/terminal/Terminal.pkg/${PV}/${P/t/T}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
DEPEND=">=dev-util/gnustep-gui-0.8.5"
