# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXfont/libXfont-0.99.0.ebuild,v 1.5 2005/08/15 15:40:10 herbs Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xfont library"
KEYWORDS="~amd64 ~s390 ~sparc ~x86"
IUSE="cid truetype type1 speedo bitmap-fonts ipv6"
RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc"
DEPEND="${RDEPEND}
	x11-proto/fontcacheproto
	x11-proto/xproto
	x11-proto/fontsproto"

CONFIGURE_OPTIONS="$(use_enable cid)
	$(use_enable speedo)
	$(use_enable truetype freetype)
	$(use_enable type1)
	$(use_enable bitmap-fonts pcfformat)
	$(use_enable bitmap-fonts bdfformat)
	$(use_enable bitmap-fonts snfformat)
	$(use_enable ipv6)"
