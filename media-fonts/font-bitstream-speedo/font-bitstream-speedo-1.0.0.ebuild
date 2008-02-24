# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-bitstream-speedo/font-bitstream-speedo-1.0.0.ebuild,v 1.11 2008/02/24 11:44:32 armin76 Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Bitstream Speedo fonts"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
RDEPEND=""
DEPEND="${RDEPEND}
	media-libs/fontconfig"
