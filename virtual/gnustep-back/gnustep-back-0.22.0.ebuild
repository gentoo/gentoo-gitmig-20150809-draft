# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gnustep-back/gnustep-back-0.22.0.ebuild,v 1.3 2012/04/07 14:46:56 maekke Exp $

DESCRIPTION="Virtual for back-end component for the GNUstep GUI Library"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""
RDEPEND="|| (
		~gnustep-base/gnustep-back-cairo-${PV}
		~gnustep-base/gnustep-back-art-${PV}
		~gnustep-base/gnustep-back-xlib-${PV}
	)"
DEPEND=""
