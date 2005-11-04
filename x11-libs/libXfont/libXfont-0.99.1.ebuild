# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXfont/libXfont-0.99.1.ebuild,v 1.3 2005/11/04 16:39:00 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xfont library"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="cid truetype speedo bitmap-fonts ipv6"
RDEPEND="x11-libs/xtrans
	x11-libs/libfontenc
	x11-proto/xproto
	x11-proto/fontsproto
	truetype? ( >=media-libs/freetype-2 )"
DEPEND="${RDEPEND}
	x11-proto/fontcacheproto"

CONFIGURE_OPTIONS="$(use_enable cid)
	$(use_enable speedo)
	$(use_enable truetype freetype)
	$(use_enable bitmap-fonts pcfformat)
	$(use_enable bitmap-fonts bdfformat)
	$(use_enable bitmap-fonts snfformat)
	$(use_enable ipv6)
	--enable-type1"
