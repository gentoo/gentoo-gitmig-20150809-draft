# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gnustep-guile/gnustep-guile-1.1.1.ebuild,v 1.4 2004/07/02 05:07:58 eradicator Exp $

inherit gnustep

DESCRIPTION="GNUstep Guile bridge"
HOMEPAGE="http://www.gnustep.org"
SRC_URI="ftp://ftp.gnustep.org/pub/gnustep/libs/${P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 -ppc -sparc "
DEPEND=">=dev-util/gnustep-base-1.6.0
	>=dev-util/guile-1.6"
RDEPEND="virtual/libc"
S=${WORKDIR}/${P}
