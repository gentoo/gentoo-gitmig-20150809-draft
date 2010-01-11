# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/gnustep-back/gnustep-back-0.14.0.ebuild,v 1.6 2010/01/11 10:59:55 ulm Exp $

DESCRIPTION="Virtual for back-end component for the GNUstep GUI Library"
HOMEPAGE=""
SRC_URI=""
LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ppc sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-solaris"
RDEPEND="|| (
		~gnustep-base/gnustep-back-art-${PV}
		~gnustep-base/gnustep-back-xlib-${PV}
		~gnustep-base/gnustep-back-cairo-${PV}
	)"
DEPEND=""
