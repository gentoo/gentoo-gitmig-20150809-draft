# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/icewm-tools/icewm-tools-2.0.ebuild,v 1.2 2003/04/24 14:11:35 phosphan Exp $

DESCRIPTION="Convenience package for IceWM control center and tools"
SRC_URI=""
HOMEPAGE=""
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-misc/icebgset-0.8
		>=x11-misc/icecc-2.0
		>=x11-misc/icecursorscfg-0.6
		>=x11-misc/iceiconcvt-0.9
        >=x11-misc/iceked-1.2
		>=x11-misc/icemc-1.2
		>=x11-misc/icesndcfg-0.8
		>=x11-misc/icets-1.0
		>=x11-misc/icewoed-1.4"

SLOT="0"

src_compile () {
	einfo "Nothing to do"
}

src_install () {
	einfo "Nothing to do"
}
