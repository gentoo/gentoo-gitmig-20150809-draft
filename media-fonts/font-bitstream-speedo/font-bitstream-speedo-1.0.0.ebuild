# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bitstream-speedo/font-bitstream-speedo-1.0.0.ebuild,v 1.2 2006/01/10 18:28:12 hansmi Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="Bitstream Speedo fonts"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
